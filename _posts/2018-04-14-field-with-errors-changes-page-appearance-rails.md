---
title: field_with_errors changes page appearance in Rails
date: 2018-04-14
author: Martin Brennan
layout: post
permalink: /field-with-errors-changes-page-appearance-rails/
---

{% include deprecated.html message="In 2025 this article is still relevant, but there is another way to approach this, see below." cssclass="deprecated" %}

It seems like it's easier to do the following to disable the behaviour entirely. Create an initializer file named `config/initializers/field_with_errors.rb`:

```ruby
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html_tag.html_safe
end
```

---

I had a minor issue with my Rails view when I had a list of radio buttons wrapped in labels. When there are form errors on a field like a radio button, Rails puts the CSS class `.field_with_errors` on that field. This causes some issues with alignment as seen in the screenshot below:

![field with errors](/images/fieldwitherrors.png)

All you need to do to fix this is make the `.field_with_errors` class display inline like so:

```css
.field_with_errors { display: inline; }
```