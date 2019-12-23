---
title: Batch Convert HEIC Files to JPEG on Windows
date: 2019-12-23T14:17:12+10:00
author: Martin Brennan
layout: post
permalink: /batch-convert-heic-files-to-jpeg-on-windows/
---

I got a new iPhone recently, and getting the photos off of it onto my PC in a way in which Lightroom could import them was a painful experience to say the least. There are a few settings on the iPhone now which cause the photos to be stored in a new HEIC format from Apple, instead of plain old JPEG. When connecting my iPhone to my Windows PC I had all sorts of issues with the PC even recognizing the phone as a storage device. To do so I had to turn off the automatic conversion of photos from HEIC while copying to the PC, and also disable the automatic compression to HEIC entirely, and turn off some iCloud settings.

EVENTUALLY I ended up with all the HEIC photos from my phone on my PC and I needed a way to convert them to JPEG en masse so I could get them into my old version of Lightroom. After searching a while I found via a Reddit post that [IfranView](https://www.irfanview.com/) has a batch convert option. This was the easiest way by far to get what I wanted on Windows. All I needed to do was go to "File > Batch conversion" in IfranView, set the output format to JPEG and change the quality to 100, and then add all the HEIC input files (note: you can go in and out of folders adding HEIC files, as the iPhone folder format is 102APPLE, 103APPLE etc.).

And that was it! The conversion took a little while but I was left with good old JPEG files.