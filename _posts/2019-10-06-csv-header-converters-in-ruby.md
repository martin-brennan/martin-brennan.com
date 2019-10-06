---
title: "CSV header converters in Ruby"
date: 2019-10-06T12:52:00+1000
author: Martin Brennan
layout: post
permalink: /csv-header-converters-in-ruby/
---

The [CSV library in the Ruby stdlib](https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html) is a really great and easy to use one, and I've often used it for data migrations and imports. When importing data I often find it useful to validate the headers of the imported CSV, to ensure that valid columns are provided. Some users may provide columns in different cases to what you expect or with different punctuation (including spaces etc.). To normalize the headers when parsing a CSV, you can use an option passed to [`new`](https://ruby-doc.org/stdlib-2.6.1/libdoc/csv/rdoc/CSV.html#method-c-new) (other methods such a `parse`, `read`, and `foreach` accept the same options) called `header_converters`. Here is a simple example of how you can convert the headers of the parsed CSV to lowercase:

```ruby
###
# Source CSV looks like:
#
# First name,last Name,Email
# Abraham,Lincoln,alincoln@gmail.com
# George,Washington,gwashington@outlook.com

downcase_converter = lambda { |header| header.downcase }
parsed_csv = CSV.parse('/path/to/file.csv', headers: true, header_converters: downcase_converter)
parsed_csv.each do |row|
  puts row['first name']

  # => Abraham
  # => George
end
```

Simple as that. You can do anything to the headers here. There are also a couple of built in header converters (`:downcase` and `:symbol`) that can be used, and an array can be passed as an argument, not just one converter. Converters can also be used for cells in the CSV rows as well, not just headers. The documentation for the Ruby `CSV` class is quite clear and helpful, take a look to see all the other myriad options for reading and writing CSVs in Ruby.

Originally, I found this solution and tweaked it a bit from this StackOverflow answer - [https://stackoverflow.com/questions/48894679/converting-csv-headers-to-be-case-insensitive-in-ruby](https://stackoverflow.com/questions/48894679/converting-csv-headers-to-be-case-insensitive-in-ruby)