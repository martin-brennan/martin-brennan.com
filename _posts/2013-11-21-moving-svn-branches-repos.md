---
id: 394
title: Moving SVN Branches and Repos
date: 2013-11-21T08:02:51+10:00
author: Martin Brennan
layout: post
guid: http://www.martin-brennan.com/?p=394
permalink: /moving-svn-branches-repos/
exclude_from_feed: true
iconcategory:
  - development
dsq_thread_id:
  - 1983821127
categories:
  - Development
tags:
  - Source Control
  - SVN
  - version control
  - VisualSVN
  - Windows
---

{% include deprecated.html message="Who uses SVN anymore? I've used git for over years now at least. Leaving this article as a historical curiosity." cssclass="danger" %}

Just a quick tip, if you need to move a SVN branch or folder around inside the repository, use the following command:

`svn move https://svn_server/svn/repo/branches/folder https://svn_server/svn/repo/branches-graveyard/folder --message "Moving branch to graveyard"`

This command can be useful when you need to move an old branch into archive or perform other branch administration in your SVN repository. At work we are using [Visual SVN server](http://www.visualsvn.com/server/), so I had to run the command in the `C:\Program Files (x86)\VisualSVN Server\bin` folder.

One final thing, you must have a commit message when running the SVN move command otherwise it will not work. For more information visit this superuser question:

[SVN - moving folders to the trunk](http://superuser.com/questions/523192/svn-moving-folders-to-the-trunk)
