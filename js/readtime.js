function calculateReadTime() {
  const postBody = document.querySelector(".post-content");
  if (!postBody) {
    return;
  }

  const approxWordCount = postBody.innerText.split(" ").length;
  const readTimeMins = approxWordCount / 250; // standard wpm

  let readTime = Math.floor(readTimeMins);

  // add 15 seconds per code block
  const numCodeBlocks = document.querySelectorAll("div.highlighter-rouge").length;
  readTime = Math.floor((readTime * 60 + numCodeBlocks * 15) / 60);

  if (readTime === 0) {
    document.querySelector(".readtime").innerHTML = "less than 1 min read";
  } else {
    document.querySelector(".readtime").innerHTML = `approx ${readTime} min read`;
  }
}

document.addEventListener("DOMContentLoaded", calculateReadTime);
