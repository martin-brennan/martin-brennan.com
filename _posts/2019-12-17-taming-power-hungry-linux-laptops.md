---
title: "Taming power-hungry linux laptops"
date: 2019-12-17T21:00:00+1000
author: Martin Brennan
layout: post
permalink: /buying-a-software-development-laptop-in-late-2019/
exclude_from_feed: true
---

{% include deprecated.html message="In 2025 I doubt this is helpful, leaving it up as a historical curiosity." cssclass="deprecated" %}

My Discourse laptop is an XPS15 7590 with the following specs:

* 32 GB, 2 x 16 GB, DDR4, 2666 MHz
* 1 TB M.2 PCIe NVMe Solid-State Drive
* NVIDIA® GeForce® GTX 1650 4GB GDDR5
* 15.6" 4K UHD touch display

Out of the box, after installing Ubuntu and KDE plasma, this thing on battery power acted like Daniel Plainview in There Will Be Blood.

![i drink your milkshake](/images/idrinkyourmilkshake.gif)

I got around 2 hours of battery life, 3 hours if I changed the resolution from 4k to 2k and dimmed the screen. The laptop was consuming between 40W and 50W of power. This isn’t great obviously, so I am posting here to list out some of the things I did to improve the battery life. The main secret is disabling the beastly graphics card which is not really needed for software development work in general.

* Install `powertop` to get a summary of what is using all the power on your computer, as well as a general overview of the wattage being consumed. The output looks like this:

![powertop start](/images/powertopstart.png)

* Run `sudo powertop --auto-tune` to automatically tune some of the settings for power, this will save you a small amount of watts.

* Install `nvidia-prime` which is used to disable the dedicated GPU. Run `sudo prime-select intel` to switch to the onboard graphics profile and reboot. This saved me about 10-15W off the bat.

* Install `tlp` which is a battery management tool for Linux. Then, all I did was start the service and apply the default power saving settings then rebooted.

```
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw 
sudo systemctl status tlp
sudo tlp start
```

* Finally install Bumblebee which is more NVidia management stuff `sudo apt-get install bumblebee bumblebee-nvidia primus linux-headers-generic` and reboot. Then run `sudo tee /proc/acpi/bbswitch <<<OFF` to completely turn off the NVidia card and reboot again. You may have to keep running this bbswitch command, I haven't quite figured this part out yet. If it seems like my watt usage is really high I just run it again.

After this was all done here was my final reading from powertop (the battery was already drained ~10-15% here):

![powertop final](/images/powertopfinal.png)

The wattage used went from 40W-50W to 10W-15W! And the battery life is now up to a more respectable ~6-7 hours. I was pretty stunned by this, thanks to Sam and the other Australian Discourse team at our Xmas lunch for convincing me that this kind of abuse of power is NOT OKAY and putting me onto disabling NVidia. Now all I have is...

![unlimited power](/images/unlimitedpower.gif)