---
id: 502
title: Run shell commands from Ruby
date: 2014-09-05
author: Martin Brennan
layout: post
permalink: /run-shell-commands-from-ruby/
exclude_from_feed: true
exclude_from_archive: true
dsq_thread_id:
  - 3044736686
categories:
  - Development
tags:
  - Ruby
---
Just a quick tip, you can run shell commands from Ruby using the following syntax:

```ruby
%x(git log)
# or
system('git log')
```
