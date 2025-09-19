---
title: "Prevent remote: true links opening in new tabs or windows in Rails"
date: 2019-08-06T11:14:00+1000
author: Martin Brennan
layout: post
permalink: /prevent-remote-true-links-opening-new-tab-rails/
exclude_from_feed: true
---

{% include deprecated.html message="Since 2019 a few things have changed:

<ul><li>Rails’ UJS stack may no longer use jQuery or $.rails, so this code may break or not even apply.</li>

<li>Monkey-patching internal UJS behavior is brittle and often causes accessibility or maintenance issues.</li>

<li>Better approaches now exist. Provide HTML fallback responses for remote links, intercept clicks via JS rather than removing URLs, or use modern Rails front-end tools (Stimulus, importmaps, non-jQuery UJS) for more robust behavior.</li>

<li>If you’re using Rails 6+ (especially Rails 7) or a JS stack without jQuery, you should not rely on this technique. Consider using click handlers or providing proper responses instead.</li>

<li>Using <code>href='javascript:void(0)'</code> is generally discouraged: it’s not semantic, can be problematic for screen readers, for users who disable JS, etc. It also breaks normal fallback behavior.</li>
</ul>" cssclass="deprecated" %}

In Rails, you can use the option `remote: true` on forms and links for Rails to automatically send AJAX requests when the form is submitted or the link is clicked. I plan to write a more in-depth article about this extremely useful feature in time, but essentially you just need to add an `X.js.erb` file in your views directory for your controller, where `X` is the action, and Rails will deliver this JS file as a response to the AJAX request and execute it. Now, most of the time you will not want these AJAX/JS-only routes to render a HTML view, but by default users can use middle click or open the `remote: true` link in a new tab, which will show a `ActionView::MissingTemplate` error because there is no `X.html.erb` file present.

<!--more-->

To get around this, we can monkey patch the `$.rails.href` function which rails uses to get the HREF attribute for `remote: true` links, and set the default behaviour of the link to `javascript: void(0)`, and store the actual HREF on a data-attribute instead:

```js
$(document).ready(function () {
  var remoteLinks = document.querySelectorAll('a[data-remote=\'true\']');

  for (var i = 0; i < remoteLinks.length; i++) {
    var link = remoteLinks[i];
    link.dataset.url = link.href;
    link.setAttribute('href', 'javascript:void(0);');
  }

  $.rails.href = function(el) {
    var element = el[0];
    if (element.dataset) {
      var url = element.dataset.url || element.dataset.href;
      if (url) { return url; }
    }
    return element.href;
  }
});
```

This effectively stops users from opening these links in new tabs or windows. Ideally you would want to respond correctly to the HTML content-type requests on those remote routes, but this is a quick and effective way to prevent the error from cropping up for the end-user.

The `$.rails` namespace is quite interesting as it contains a lot of functions that Rails uses for this automatic AJAX functionality, and a lot of potential places for JS monkey-patching or function overriding. I'm going to have a further look into the JS functions present there to see if there is any other behaviour that can be changed. Note that if your AJAX request creates more link elements with `data-remote="true"` on them, you would need to run the `remoteLinks` href swapping code again for the new elements. The `$.rails.href` code only needs to be run once per page load.

Originally, I found this solution and tweaked it a bit from this StackOverflow answer - [https://stackoverflow.com/questions/24227586/rails-link-to-with-remote-true-and-opening-it-in-a-new-tab-or-window](https://stackoverflow.com/questions/24227586/rails-link-to-with-remote-true-and-opening-it-in-a-new-tab-or-window)