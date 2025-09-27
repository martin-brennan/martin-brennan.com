---
id: 698
title: Duration parsing using juration
date: 2015-07-19
author: Martin Brennan
layout: post
permalink: /duration-parsing-using-juration/
exclude_from_feed: true
dsq_thread_id:
  - 3948324658
categories:
  - Development
tags:
  - date
  - duration
  - Javascript
  - juration
  - parsing
---

{% include deprecated.html message="In 2025 Juration hasn't had a commit in 10 years, I no longer recommend you follow the advice in this article." cssclass="danger" %}

I’ve been working a lot with appointments and calendaring lately, and one of the requirements to create a new appointment was to have a duration parsing input that was easy to use. One that would let the user input combinations like `1h 10m` or `3h` or `25mins`. It didn’t take me long to find [Juration](https://github.com/domchristie/juration).

It’s a simple little library, only 2.6kb minified that does one thing and does it well, and it was exactly what I needed. For the string inputs, juration will return the equivalent number of seconds, which you can then determine the hours, minutes and seconds from. For example:

```javascript
juration.parse('1h 30m');
// 5400
```

Juration also works the other way, you can give it a number of seconds and a formatting option and it will output the string representation, for example:

```javascript
juration.stringify(5400, { format: 'long' });
// 1 hour 30 minutes
```

Juration parses anything from seconds up to years and is a simple, elegant solution for parsing duration inputs.
