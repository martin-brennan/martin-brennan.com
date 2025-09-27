---
title: Getting nodejs file permissions from fs.stat or fsPromises.stat mode
date: 2018-06-30
author: Martin Brennan
layout: post
permalink: /nodejs-file-permissions-fstat/
---

{% include deprecated.html message="Update in 2025, changed to use the fsPromises.stat module, which can be used `async`, otherwise the point of this article is unchanged." cssclass="info" %}

When you need to get file stats using NodeJS (which calls the unix `stat` command in the background), you can use the [`fsPromises.stat`](https://nodejs.org/api/fs.html#fspromisesstatpath-options) call as shown below:

```js
import { stat } from 'node:fs/promises';
const stats = stat('path/to/file');
```

The `stats` object returned here is an instance of [`fs.Stats`](https://nodejs.org/api/fs.html#class-fsstats) which contains a `mode` property. You can use this property to determine the unix file permissions for the file path provided. The only problem is that this `mode` property just gives you a number (as referenced in [this GitHub issue](https://github.com/nodejs/node-v0.x-archive/issues/3045)). To view the permissions in the standard unix octal format (e.g. 0445, 0777 etc) you can use the following code:

```js
const unixFilePermissions = '0' + (stats.mode & parseInt('777', 8)).toString(8);
```

Some examples of the `mode` before and after calling the above snippet:

```
33188 -> 0644
33261 -> 0755
```
