---
title: ImageMagick unable to load module error on AWS Lambda
date: 2019-07-29T20:20:00+1000
author: Martin Brennan
layout: post
permalink: /imagemagick-unable-to-load-module-error-aws-lambda/
redirects:
- /2019-07-28-imagemagick-unable-to-load-module-error-aws-lambda/
---

Last Friday we started seeing an elevated error rate in our AWS Lambda function that converted single page PDFs into images using ImageMagick. We had been seeing the same error crop up randomly in around a two week period before Friday, but we were busy with other things and didn't look too deeply into it. This was a mistake in retrospect. Below is the error in question:

```
Error: Command failed: identify: unable to load module `/usr/lib64/ImageMagick-6.7.8/modules-Q16/coders/pdf.la': file not found @ error/module.c/OpenModule/1278.
identify: no decode delegate for this image format `/tmp/BEQj9G8xj1.pdf' @ error/constitute.c/ReadImage/544.
```

To figure out the dimensions of the PDF, to convert it to an image, and to optimize the size we were using [the gm nodejs package](https://aheckmann.github.io/gm/). This is just a friendly wrapper around calling `ImageMagick` directly. `ImageMagick` version 6.8 is installed on AWS lambda base images by default. It took a while and a lot of googling and experimentation to figure out the error what the error was from. I found [a StackOverflow question](https://stackoverflow.com/questions/57067351/imagemagick-not-converting-pdfs-anymore-in-aws-lambda?noredirect=1#comment100713341_57067351) which was pivotal. It held vital information and pointed to a blog post [on the AWS blog](https://aws.amazon.com/blogs/compute/upcoming-updates-to-the-aws-lambda-execution-environment/) which talked about upcoming changes to the Lambda execution environment and a migration window. There was only one problem.

We were at the very end of the migration window.

Turns out Amazon likely removed a module referenced by `pdf.la`, which makes it so **converting PDFs to images using ImageMagick no longer works on AWS Lambda**. Now, the fix to this was essentially to use GhostScript instead to convert the PDFs to images, and then still use `ImageMagick` to resize the images. The steps I followed were (applicable to nodejs):

1. Include the `bin` and `share` directories from [https://github.com/sina-masnadi/lambda-ghostscript](https://github.com/sina-masnadi/lambda-ghostscript) into our Lambda function, so we had a compiled version of GhostScript that worked on AWS Lambda.
2. Change the JS code to call the GhostScript command to convert the PDF (sample below, [command here](https://stackoverflow.com/a/33528730))
3. Upload the new code to lambda and make sure everything still worked (it did!)

The [answer on the StackOverflow question above](https://stackoverflow.com/a/57230609/875941) is similar to the process I followed but I didn't bother with lambda layers. Here is what our JS function to convert the PDF to image looks like:

```javascript
// tempFile is the path to the PDF to convert. make sure
// your path to the ghostscript binary is set correctly!
function gsPdfToImage(tempFile, metadata, next) {
  console.log('Converting to image using GS');
  console.log('----------------------------')
  console.log(execSync('./bin/gs -sDEVICE=jpeg -dTextAlphaBits=4 -r128 -o ' + tempFile.replace('.pdf', '.jpeg') + ' ' + tempFile).toString());
  next(null, tempFile.replace('.pdf', '.jpeg'), metadata);
}
```

After I put the fix in place all the errors went away! Lesson learned for next time...pay more attention to the AWS blog! Here is our Lambda function success/error rate chart for last Friday (errors in red). It's easy to see where the fix went live:

![imagemagick lambda errors](/images/imagemagick_lambda_errors.png)