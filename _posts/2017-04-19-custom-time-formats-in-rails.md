---
title: Custom time formats in Rails
date: 2017-04-19
author: Martin Brennan
layout: post
permalink: /custom-time-formats-in-rails/
---

{% include deprecated.html message="In 2025 this still works in Rails, but it is likely better to rely on other methods like defining time formats in the Rails I18n system yaml files and using <code>I18n.l</code> rather than <code>Time.to_fs(:format)</code>" cssclass="deprecated" %}

If you need to set up custom date formats in Rails, for example to show in Views, you can do so by creating a `config/initializers/time_formats.rb` file and adding as many of the following as you want:

```ruby
Time::DATE_FORMATS[:au_datetime] = '%e/%m/%Y %I:%M%P'
Time::DATE_FORMATS[:au_date] = '%e/%m/%Y'
```

You can even use lambdas when defining a format, which will be executed using `.call` when you call `to_s` on your `Time`:

```ruby
Time::DATE_FORMATS[:short_ordinal]  = ->(time) { time.strftime("%B #{time.day.ordinalize}") }
```

This is covered in more detail in the Rails `Time` documentation here:

[https://api.rubyonrails.org/classes/Time.html#method-i-to_fs](Time#to_fs)