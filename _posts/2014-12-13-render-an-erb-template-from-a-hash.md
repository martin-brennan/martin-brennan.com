---
id: 544
title: Render an ERB template from a Hash
date: 2014-12-13
author: Martin Brennan
layout: post
permalink: /render-an-erb-template-from-a-hash/
exclude_from_feed: true
exclude_from_archive: true
dsq_thread_id:
  - 3319175788
categories:
  - Aha!
  - Development
tags:
  - erb
  - hash
  - Ruby
  - template
---

I needed to render an ERB template from a hash for external email templates, and found that this is not as straightforward as you might think. I found a blog post on splatoperator.com with a way to accomplish this. Basically, the hash needs to be converted into an OpenStruct before passing it to the ERB template.

[Render a template from a hash in Ruby (splatoperator.com)](http://splatoperator.com/2012/07/render-a-template-from-a-hash-in-ruby/)

The important part of the article and the code snippet demonstrating the functionality are below:

> You have to set the binding for ERB by saying opts.instance\_eval {binding}. This runs binding in the context of the opts object, so then calls to methods like first\_name made by ERB in this context will evaluate to the values of our hash.



This will of course result in “Hello Martin Brennan.”
