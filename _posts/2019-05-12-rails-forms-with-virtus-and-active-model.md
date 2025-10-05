---
title: Rails Forms with Virtus and ActiveModel
date: 2019-05-12
author: Martin Brennan
layout: post
permalink: /rails-forms-with-virtus-and-active-model/
---

{% include deprecated.html message="In 2025 the Virtus project has been discontinued, replaced by dry-types, dry-struct, and dry-schema, and really the general dry-rb ecosystem. Consider using them instead, and see this article as a relic of the time." cssclass="danger" %}

I absolutely HATED doing forms in Rails, until we came across this method of doing them at work. Our goal was to make forms simple to set up and to have clear logic and separation of concerns. We were using [Reform](https://github.com/trailblazer/reform) at first, and although it worked well for simple one-to-one form-to-model relationships, it quickly fell apart with more complex model relationships were involved. As well as this, if there were complex validations or different logic paths when saving the forms, things quickly fell apart. And there was no way to control the internal data structure of the form. Enter [Virtus](https://github.com/solnic/virtus) and [ActiveModel](https://github.com/rails/rails/tree/master/activemodel).

<!--more-->

Virtus is used to define attributes on a class and the types of those attributes, and supports data coercion. As well as this, Virtus enables mass assignment of attributes from hashes when initializing the class using `Virtus.model`; perfect for forms. Virtus brings other powerful features to the table to, like default values. Check out the docs for more! (note that while Virtus says it is discontinued, the actual gem works fine. The author has created several other projects since virtus that he links to in the repo)

The inclusion of ActiveModel in your form classes gives you access to the `validate` and `validates` methods, among other functionality including custom validations, translation, and serialization. You might write a custom validation method, and within it add an error to the form via the `errors.add(:base, message)` call when it meets a failure condition. Calling `.valid?` on the form will trigger all validations on the form. Very powerful!

### Persist Logic

One of the most compelling reasons to use POROs combined with Virtus is the control you have over form persistence logic. You can create a `save` method like so in your class, that does whatever you need it to. Note that in this case we are calling the `attributes` method which converts all of the form attributes into a hash:

```ruby
class BookCreateForm
  include ActiveModel::Model
  include Virtus.model

  attribute :title, String
  attribute :isbn, String
  attribute :author, String
  attribute :genre, String

  def save
    return false unless valid?
    Book.create(attributes)
  end
end
```

This persistence logic can be as complex or as simple as you need. For example, we could make this book create form into an upsert form by including an `id` and changing the persistence logic:

```ruby
class BookUpsertForm
  # ....
  attribute :id, Integer

  def save
    return false unless valid?
    return Book.update(id, attributes.except(:id)) if id.present?
    Book.create(attributes)
  end
end
```

You may want to abstract your save logic out into another service, enqueue a resque job after the form is saved, or any other number of possibilities. The point is that you can do whatever you like when saving your form's data to the database. Another great idea is to abstract the inclusion of `Virtus` and `ActiveModel` into a base form class so you don't have to do it all the time (and you can add other useful methods there too):

```ruby
class BaseForm
  include ActiveModel::Model
  include Virtus.model

  def save
    return false unless valid?

    # you would just override this method in any class
    # inheriting from BaseForm
    save_form
  end
end
```

### Validations

It's extremely important to have server-side validations for your rails forms, and not to just rely on HTML5 validations. The hierarchy of data validation should be as follows:

1. Client   - HTML5 form validations, `required` attribute
2. Server   - ActiveModel form validations and logic
3. Database - NOT NULL, CHECK and UNIQUE constraints, etc.

ActiveModel's form validations make it very easy to fulfil the second level. Say for the example above I want to ensure that the title and ISBN number is always present for the book. I would just add this:

```ruby
validates :title, :isbn, :genre, :author, presence: true
```

And if I call my `save` method without filling these values in, I would see an error when I check the `errors` object:

```ruby
book_form = BookUpsertForm.new({})
book_form.save
puts book_form.errors.full_messages
=> ["Title is required", "ISBN is required"]
```

It is easy show these errors to the user. Usually the form would be stored in a facade or similar, which would be stored in a controller instance variable. Then in the view you would just do something like:

```erb
<% if @facade.form.errors.full_messages.length.positive? %>
  <ul>
  <% @facade.form.errors.full_messages.each do |message| %>
    <li><%= message %></li>
  <% end %>
  </ul>
<% end %>
```

If I wanted to do something fancier I could create a custom validation method. Say if I needed to check the format of the ISBN, I could do the following:

```ruby
validate :isbn_ok?

def isbn_ok?
  return if ISBNFormatCheck.format_ok?(isbn)
  errors.add(:base, 'ISBN is in an invalid format')
end
```

Adding errors from the custom validators to the `errors` block is extremely powerful. If you want, you can replace `:base` with an attribute name and rails will humanize it for you, e.g. `errors.add(:isbn, 'is an invalid format')`. This can then also be easily tied into `I18n`.

### Custom Validators

Sometimes you may want to use the same validation in many different forms. You can create custom validators using `ActiveModel::Validator`. Here is one for validating the ISBN formats:

```ruby
class ISBNFormatValidator < ActiveModel::Validator
  def validate(record)
    return if ISBNFormatCheck.format_ok?(isbn)
    errors.add(:base, 'ISBN is in an invalid format')
  end
end
```
Then, to include this in a form you use the `validates_with` method:

```ruby
class BookUpsertForm
  validates_with ISBNFormatValidator

  # form logic
end
```

### Putting it All Together

Taking our example of the `BookUpsertForm` above we can put everything together and make a form with custom validations that can create or update a book, then enqueue a background long running job. You can see how everything works together in the code below:

```erb
<% if form.errors.full_messages.length.positive? %>
  <ul>
  <% form.errors.full_messages.each do |message| %>
    <li><%= message %></li>
  <% end %>
  </ul>
<% end %>
```

```ruby
class BaseForm
  include ActiveModel::Model
  include Virtus.model

  def save
    return false unless valid?

    # you would just override this method in any class
    # inheriting from BaseForm
    save_form
  end
end
```

```erb
<%= form_for(@facade.form, url: @facade.form.id.present? ? book_path(@facade.form.id) : book_new_path, method: @facade.form.id.present? : :patch : :post) do |f| %>
  <%= render 'form_errors', form: @facade.form %>
  <div class="form-group">
    <%= f.label :title %>
    <%= f.text_field :title, required: true %>
  </div>
  <div class="form-group">
    <%= f.label :isbn %>
    <%= f.text_field :isbn, required: true %>
  </div>
  <div class="form-group">
    <%= f.label :author %>
    <%= f.text_field :author, required: true %>
  </div>
  <div class="form-group">
    <%= f.label :genre %>
    <%= f.select :genre, options_for_select(@facade.genre_options, @facade.form.genre), { prompt: 'Please Select' }, required: true %>
  </div>
  <%= f.hidden_field :id, value: @facade.form.id %>
  <div class="form-group">
    <%= f.submit %>
  </div>
<% end %>
```

```ruby
class BookUpsertForm < BaseForm
  validates_with ISBNFormatValidator
  
  attribute :id, Integer
  attribute :title, String
  attribute :isbn, String
  attribute :author, String
  
  validate :title, :isbn, :author, presence: true

  def save_form
    Book.transaction do
      commit_book_changes
      enqueue_background_job
    end
  end
  
  private
  
  def commit_book_changes
    return Book.update(id, attributes.except(:id)) if id.present?
    @id = Book.create(attributes).id
  end
  
  def enqueue_background_job
    Resque.enqueue(BookChangeNotifier, id)
  end
end
```

```ruby
class BooksController < ApplicationController
  def new
    # form logic is inside the facade
    @facade = BookUpsertFacade.new
  end
  
  def create
    @facade = BookUpsertFacade.new(params)
    return redirect_to(book_path(@facade.form.id)) if @facade.form.save
    flash[:warning] = 'There were validation errors encountered when creating the book'
    render :new
  end
  
  def edit
    @facade = BookUpsertFacade.new(params)
  end
  
  def update
    @facade = BookUpsertFacade.new(params)
    return redirect_to(book_path(@facade.form.id)) if @facade.form.save
    flash[:warning] = 'There were validation errors encountered when updating the book'
    render :edit
  end
end
```

```ruby
class ISBNFormatValidator < ActiveModel::Validator
  def validate(record)
    return if ISBNFormatCheck.format_ok?(isbn)
    errors.add(:base, 'ISBN is in an invalid format')
  end
end
```

### Side Note - Data Transfer Objects

Another neat side effect of using Virtus that we have found is the ability to use it to create Data Transfer Objects (DTOs) or payload classes for other services. For example, if you have a service that fetches the data used to generate a report. You could perform the logic of fetching the data and doing some operations on it to mould it into a format that your report presenter can use. We often just define these DTO classes inside the service class. A Virtus DTO is perfect for that:

```ruby
class BookSalesReportDataService
  class BookSalesReportDataItem
    include Virtus.model

    attribute :title, String
    attribute :isbn, String
    attribute :author, String
    attribute :genre, String
    attribute :total_sales, Float
  end

  def fetch
    retrieve_data.map do |row|
      BookSalesReportDataItem.new(
        title: row.title,
        isbn: row.isbn,
        author: row.author,
        genre: row.genre,
        total_sales: (row.qty_sold * row.price)
      )
    end
  end

  private

  def retrieve_data
    # gets data from database
  end
end
```

We have been extremely happy with the power of Virtus in our Rails monolith. Give it a try!