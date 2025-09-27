---
title: Subset sum problem in Ruby
date: 2019-04-28
author: Martin Brennan
layout: post
permalink: /subset-sum-problem-ruby/
---

I came across a bizarre data storage decision in a recent data migration. For context, in Australia there is a kind of government demographic survey that must be reported to by certain organisations. One of the data points is “Qualifications Achieved” or something to that affect, which accepts a comma-separated list of values. For example, the qualifications and their values are similar to:

```
524 - Certificate I
521 - Certificate II
514 - Certificate III
410 - Advanced Diploma
008 - Bachelor Degree
```

If a person had achieved a Certificate III and a Bachelor, you would report `514,008` for that person to the government, for that data point. In the database in question there was a column which stored a single value. In this case it was 522, which is `514 + 008`. So, if I wanted to break apart this number into its component parts to store it a bit more sensibly, I needed to figure out which of the source numbers added up to the target number.

I’m sure any developer reading this has had a problem where they are sure there is an answer, but they just don’t know what to search for. After some Googling it turns out this is called the subset sum problem. And someone had thoughtfully made an implementation in ruby which I could use:

[http://ruby-subsetsum.jeremyevans.net](http://ruby-subsetsum.jeremyevans.net)

Note that in my case I needed only _one_ output set, which worked because all the number combinations in my source set of numbers provide a unique result. E.g. for the numbers above no combination except `514 + 008` adds up to 522. If you need it to this algorithm also returns multiple number sets that add up to the total.

So, I took the algorithm, took my source numbers for each different data point, and my totals from the database, and it spat out the correct combinations! `1053 = 008 + 521 + 524`. Aren’t algorithms magic sometimes?
