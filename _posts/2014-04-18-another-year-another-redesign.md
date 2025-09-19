---
id: 441
title: Another year, another redesign
date: 2014-04-18T16:25:45+10:00
author: Martin Brennan
layout: post
permalink: /another-year-another-redesign/
exclude_from_feed: true
dsq_thread_id:
  - 2620672094
categories:
  - Design
---

{% include deprecated.html message="I've redesigned again since this article, though you may find some of the links helpful." cssclass="deprecated" %}

We are in the future of 2014 and since it’s been about a year since I’ve changed this blog’s design, I thought time would be ripe to do it again! It’s taken me quite while longer than I would have like this time, but I have a good excuse for that in the form of the birth of my first son!<!--more-->

I’ve based this design on themes I’ve seen for [Octopress](http://octopress.org/), with a large area to place more importance on the content of the blog. I’ve also added a sidebar back in because the site is now 100% width, with a focus on search. I’ve been using a great search plugin called [Relevanssi](https://wordpress.org/plugins/relevanssi/ "relevanssi") that replaces the default WordPress search, and adds features like indexing, result weighting and search hit highlighting.

For the sidebar icons I used [Simple Icons](http://simpleicons.org/) and once again I’ve used the excellent [highlightjs](http://highlightjs.org/) for syntax highlighting of code snippets, for example on the JavaScript I used to highlight the currently selected page!

```javascript
var page = window.location.href;
if (page.indexOf('archive') != -1) {
  var link = document.getElementById('nav_archive');
  link.className = 'selected';
} else if (page.indexOf('about') != -1) {
  var link = document.getElementById('nav_about');
  link.className = 'selected';
} else {
  var link = document.getElementById('nav_articles');
  link.className = 'selected';
}
```

Let me know what you think! Here is a comparison of old vs. new!

**New**

![new design](/images/new.jpg)

**Old**

![old design](/images/old.jpg)
