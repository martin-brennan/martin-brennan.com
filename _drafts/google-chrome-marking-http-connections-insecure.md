---
title: Google Chrome to Start Marking HTTP Connections Insecure
date: 2016-09-09T20:00:00+00:00
author: Martin Brennan
layout: post
permalink: /google-chrome-start-marking-http-connections-insecure/
---

Google Chrome has been steadily marching toward this end for some time now. [From January 2017, Google will start flagging pages served over HTTP](http://www.totalitech.com/2016/09/08/google-chrome-start-marking-http-connections-insecure/) as Not Secure. The way that this will work in Chrome is that indicator will be displayed in front of the address bar like they currently do with websites served over HTTPS with an invalid certificate. This will only be done on pages with credit card or password fields, which should have been served over HTTPS in the first place. [Firefox has already adopted this behaviour](https://blog.mozilla.org/tanvi/2016/01/28/no-more-passwords-over-http-please/), and their main reasons for doing this, along with the Chrome team, is that it prevents MITM (Man in the Middle) attacks.



- not really any excuse any more
- google will do it for pages with password or credit card fields
- may desensitize people to actually insecure pages though
- still been meaning to find time to do it for my blog
