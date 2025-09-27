---
title: HiDPI fix for Spotify on Ubuntu
date: 2019-12-21
author: Martin Brennan
layout: post
exclude_from_feed: true
permalink: /hidpi-fix-for-spotify-on-ubuntu/
---

{% include deprecated.html message="In 2025 this is likely irrelevant, leaving it up for historical curiosity only." cssclass="deprecated" %}

There are many HiDPI/4K scaling issues on Ubuntu and Linux in general, and one of the most annoying is that Spotify becomes a music player for ants. To fix the tiny UI, you can first find where Spotify is installed on Ubuntu by searching for it in Applications, right clicking on the application and clicking properties. A couple of examples of what the file location could be:

* /var/lib/snapd/desktop/applications/spotify_spotify.desktop
* /home/martin/.local/share/applications/spotify.desktop

If you edit the file in vim you will see an Exec command that looks something like this:

```
Exec=spotify %U
```

You can add `--force-device-scale-factor=1.5` to the command and this will fix the HiDPI scaling issue for you. You will just have to relaunch Spotify for this to take effect. See [https://community.spotify.com/t5/Desktop-Linux/Linux-client-barely-usable-on-HiDPI-displays/td-p/1067272](https://community.spotify.com/t5/Desktop-Linux/Linux-client-barely-usable-on-HiDPI-displays/td-p/1067272) for more information.

After a while I updated Spotify and I got a newer version installed using snap. If you are using the newer snap install you do the same, only in the /var/lib/snapd/desktop/applications/ directory which will be shown in the spotify.desktop file. For example the snap Exec command may look something like this:

```
Exec=env BAMF_DESKTOP_FILE_HINT=/var/lib/snapd/desktop/applications/spotify_spotify.desktop /snap/bin/spotify --force-device-scale-factor=1.5 %U
```

For more information on the snap fix check out this post [https://community.spotify.com/t5/Desktop-Linux/Spotify-Hi-DPI-Fix-for-Snap-install/td-p/4576328](https://community.spotify.com/t5/Desktop-Linux/Spotify-Hi-DPI-Fix-for-Snap-install/td-p/4576328).
