---
id: 582
title: Highlighting JavaScript this Keyword in Sublime Text 2
date: 2015-02-01T19:32:04+00:00
author: Martin Brennan
layout: post
guid: http://www.martin-brennan.com/?p=582
permalink: /highlighting-javascript-keyword-sublime-text-2/
dsq_thread_id:
  - 3474766458
mashsb_shares:
  - 0
mashsb_timestamp:
  - 1464919887
mashsb_jsonshares:
  - '{"total":0}'
categories:
  - Development
tags:
  - Javascript
  - Sublime Text 2
  - Theme
  - this
---
I&#8217;ve looked for something like this before but I&#8217;ve only recently found it. Sublime Text 2 uses textmate themes which can use regular expressions and scopes to highlight certain keywords that are only relevant in certain languages. I got a new theme which I love called [itg.flat](https://github.com/itsthatguy/theme-itg-flat "itg.flat") and while the colors are great, it was lacking a highlight for the `this` keyword in JavaScript, which makes in harder to spot and locate scope issues.

I found this on a Sublime Text 2 forum post, which highlights the keyword. You just need to add this to the `.tmtheme` file for your theme, which will usually be located in `{user}/Library/Application Support/Sublime Text 2/Packages/Theme - Name/` for Mac and `%APPDATA%\Sublime Text 2\Packages\Theme - Name\` in Windows:



You can get rid of the bold/italic if you want or change the hex color code too. You may also want to check out the [Sublime Text 2 Color Scheme Editor](https://github.com/facelessuser/ColorSchemeEditor). Here you can see the result. Before:

[<img src="http://www.martin-brennan.com/wp-content/uploads/2015/02/before.png" alt="before" style="width: 100%;" class="alignnone size-full wp-image-584" srcset="http://www.martin-brennan.com/wp-content/uploads/2015/02/before.png 870w, http://www.martin-brennan.com/wp-content/uploads/2015/02/before-300x207.png 300w" sizes="(max-width: 870px) 100vw, 870px" />](http://www.martin-brennan.com/wp-content/uploads/2015/02/before.png)

After:

[<img src="http://www.martin-brennan.com/wp-content/uploads/2015/02/after.png" alt="after" style="width: 100%;" class="alignnone size-full wp-image-583" srcset="http://www.martin-brennan.com/wp-content/uploads/2015/02/after.png 847w, http://www.martin-brennan.com/wp-content/uploads/2015/02/after-300x214.png 300w" sizes="(max-width: 847px) 100vw, 847px" />](http://www.martin-brennan.com/wp-content/uploads/2015/02/after.png)