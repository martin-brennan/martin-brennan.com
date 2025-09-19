---
id: 290
title: Using Reserved Words as Identifiers in VB.NET by Theo Gray
date: 2013-02-15T18:23:19+10:00
author: Martin Brennan
layout: post
guid: http://www.martin-brennan.com/?p=290
permalink: /using-reserved-words-as-identifiers-in-vb-net/
iconcategory:
  - Development
dsq_thread_id:
  - 1084293286
categories:
  - Development
tags:
  - ASP.NET
  - Javascript
  - Languages
  - Programming
  - Reserved Keywords
  - VB.NET
---

{% include deprecated.html message="This is from 2013 so now likely irrelevant, and I haven't used VB.NET in years, leaving it up for historical curiosity only." cssclass="deprecated" %}

I came across a problem at work the other day when the plugin that I was using, [jQuery file uploader](http://blueimp.github.com/jQuery-File-Upload/), required specific properties to be returned to it from the VB.NET object de-serialization when an error occurred. One of these properties was `Error`, which is a [reserved language keyword](http://www.theogray.com/blog/2009/03/using-reserved-words-as-identifiers-in-vbnet) in VB.NET. Ordinarily I would never be using reserved words as identifiers in VB.NET, since you can’t anyway because the compiler doesn’t allow it and it’s usually a very bad idea. But in this case it was either use a reserved keyword or have to modify the plugin source which I wasn’t too keen on doing.

I came across this article by [Theo Gray](http://www.theogray.com/blog/2009/03/using-reserved-words-as-identifiers-in-vbnet) that outlined that it was as simple as surrounding the property in square brackets `[]`, much in the same way you can use [reserved keywords as column names in MSSQL](http://stackoverflow.com/questions/285775/how-to-deal-with-sql-column-names-that-look-like-sql-keywords). This worked great and it was a perfectly simple solution to my problem, but I certainly won’t be making a habit of it!
