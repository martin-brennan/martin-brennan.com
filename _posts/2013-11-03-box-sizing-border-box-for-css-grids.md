---
id: 382
title: Box-sizing border-box for CSS grids
date: 2013-11-03
author: Martin Brennan
layout: post
permalink: /box-sizing-border-box-for-css-grids/
exclude_from_feed: true
dsq_thread_id:
  - 1931230816
categories:
  - Design
  - Share
tags:
  - border-box
  - box-sizing
  - CSS
  - framework
  - grid
---

{% include deprecated.html message="This article was written in 2013, when float-based and custom grid systems were common. Today, the recommended approach is to use native CSS Grid or Flexbox." cssclass="danger" %}

I was working on a grid system in CSS for a style framework I'm making for work, and I ran into a few problems when styling the grid. Specifically, I was having trouble with aligning all of the columns side-by-side while simultaneously giving each column sufficient padding. There is a CSS property called `box-sizing`, which has a default value of `content-box`. The problem with this is that for block elements such as `divs`, properties like borders and padding **add width** to the element, even if it already has a fixed width. This is particularly troublesome with grids, because we need to have each column the correct width regardless of padding applied to it.<!--more-->

Thankfully, there is another value that can be used for the `box-sizing` property called `border-box`, which ensures the element that it is applied to **stays the same width**, regardless of any padding or borders applied to it. Chris Coyier has a great article on how this box model applies to grids:

[Don't Overthink it Grids by Chris Coyier](http://css-tricks.com/dont-overthink-it-grids/)

And Paul Irish also has an in-depth explanation about the box model and the usage border-box. The article is a great read and lists the pros of using this property:

[* { Box-sizing: Border-box } FTW](http://www.paulirish.com/2012/box-sizing-border-box-ftw/)
