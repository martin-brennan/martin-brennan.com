function calculateReadTime() {
  var postBody = document.querySelector('.post-content');
  if (!postBody) { return; }

  var approxWordCount = postBody.innerText.split(' ').length;
  var readTimeMins = approxWordCount / 250; // standard wpm

  var readTime = Math.floor(readTimeMins);

  // add 15 seconds per code block
  var numCodeBlocks = document.querySelectorAll('div.highlighter-rouge').length;
  readTime = readTime * 60 + (numCodeBlocks * 15);
  readTime = Math.floor(readTime / 60);

  document.querySelector('.readtime').innerHTML = 'approx ' + readTime + ' min read';
}

document.addEventListener('DOMContentLoaded', calculateReadTime);