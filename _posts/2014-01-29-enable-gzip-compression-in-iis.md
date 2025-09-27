---
id: 411
title: Enable gzip compression in IIS
date: 2014-01-29T07:16:07+10:00
author: Martin Brennan
layout: post
permalink: /enable-gzip-compression-in-iis/
exclude_from_feed: true
dsq_thread_id:
  - 2187514105
categories:
  - Development
  - Tutorial
tags:
  - gzip
  - iis
  - iis express
  - json
  - server
  - Windows
---

{% include deprecated.html message="In 2025 this article is over ten years old and is likely out of date. Leaving it as a historical curiosity." cssclass="danger" %}

For an API I am building, I needed to enable Gzip compression in IIS Express for JSON and came across [GZip response on IIS Express](http://stackoverflow.com/questions/10102743/gzip-response-on-iis-express).

There are just two commands to run. This example is for IIS Express but the same commands work in IIS:

```shell
cd %PROGRAMFILES%IIS Express
appcmd set config -section:urlCompression /doDynamicCompression:true
appcmd set config /section:staticContent /+[fileExtension='.json',mimeType='application/json']
appcmd.exe set config -section:system.webServer/httpCompression /+"dynamicTypes.[mimeType='application/json',enabled='True']" /commit:apphost
```

Then, restart IIS or IIS Express afterwards. Gzip compression is very beneficial, and it lowered response sizes for JSON API requests dramatically, sometimes by greater than 50%.
