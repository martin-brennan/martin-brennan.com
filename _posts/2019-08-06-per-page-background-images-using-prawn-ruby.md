---
title: Per-page background images using prawn and Ruby
date: 2019-08-06T12:02:00+1000
author: Martin Brennan
layout: post
permalink: /per-page-background-images-using-prawn-ruby/
---

[Prawn](https://github.com/prawnpdf/prawn) is an excellent PDF generation library for ruby, and we use it for all our PDF needs at work (Webbernet at time of writing). [Their manual](http://prawnpdf.org/manual.pdf) is some of the best documentation I have read. Recently, I needed to set a different background image on every page of a PDF I was generating. The prawn documentation, while good, only shows how to use a background image for the whole PDF:

```ruby
img = "some/image/path.jpg"

Prawn::Document.generate(filename, background: img, margin: 100) do |pdf|
  pdf.text 'My report caption', size: 18, align: :right
end
```

So, I decided to dig into their source code to see how they rendered the background image. After a short search I found what I needed. Turns out, this works for rendering multiple different background images! In prawn you can call `pdf.start_new_page` to start a new page, and on each new page I would call the following to set the new background for that page:

```ruby
background_image_path = 'some/path/for/this/page.jpg'
pdf.canvas do
  pdf.image(background_image_path, scale: 1, at: pdf.bounds.top_left)
end
```

I was able to generate the PDF with different background images perfectly with this code.