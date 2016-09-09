---
title: Unit testing in AngularJS Mark. II
date: 2016-09-01T20:00:00+00:00
author: Martin Brennan
layout: post
permalink: /unit-testing-in-angular-js-mk-ii/
---

the long and short of it is that unit testing in angularjs is still a colossal pain in the ass. i've gone through a few different solutions for it now, even blogged about it, and everything so far has fallen flat. karma, the proscribed medicine, doesn't cure what ails ya if you are using ES6 and systemjs, it feels like you are actively fighting to smush a lot of disparate tools together that are simply not made to work well together. there hasn't really been any improvement in karma in a long time, i guess because everyone is declaring angular 1 doa because angular 2 is coming up, so i decided to do away with the automated "just install this and you're good to go" solutions and roll my own. so make like you're married to max power and strap yourself in and feel the g's.

- the setup - an angularjs spa using ES6 transpiled with traceur and an index.html page that uses system.js to load modules, and bower for other external dependencies
- unit testing framework - jasmine. has a jserrorreporter that is very flexible that you can mould the test results into your own graven image.
- test capturing - phantomjs. this has only been possible recently when v2 finally went live, implementing a version of webkit that wasn't around when moses wore short pants
- server - expressjs - i tried a few different ways of doing this and express is great because it's lightweight, runs in the background, and closes easily

what we need

- jasmine spec runner js file
- phantomjs runner code
- code to transform test results
- index.html page to load all dependencies
- a console you dip
