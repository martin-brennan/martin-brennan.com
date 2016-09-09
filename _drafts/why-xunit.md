---
title: Why xUnit?
date: 2016-09-01T20:00:00+10:00
author: Martin Brennan
layout: post
permalink: /why-xunit/
---

- Can assert thrown exceptions e.g. Exception ex = Assert.Throws<ArgumentException>(() => {
    a.b();
  });

- The Theory attribute lets you pass in different data for the same test via the InlineData(x) attribute
- Better stack traces for errors/failed tests
- xUnit more extensible via the Fact and Theory class
- Getting started https://xunit.github.io/docs/getting-started-desktop.html
- Comparison to other frameworks https://xunit.github.io/docs/comparisons.html
- Doesn't need a unit test project, you can just do a class library
- Can't run MSTest tests standalone on build server without installing VS? http://stackoverflow.com/questions/261139/nunit-vs-mbunit-vs-mstest-vs-xunit-net
- http://xunit.github.io/docs/why-did-we-build-xunit-1.0.html
