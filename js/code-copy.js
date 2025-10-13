// Code block copy functionality
document.addEventListener('DOMContentLoaded', function() {
  // Find all copy buttons
  const copyButtons = document.querySelectorAll('.code-copy-button');

  copyButtons.forEach(function(button) {
    button.addEventListener('click', function() {
      // Find the code block associated with this button
      const codeBlock = button.closest('.highlighter-rouge');
      if (!codeBlock) return;

      // Get the code content from the pre > code element
      const codeElement = codeBlock.querySelector('pre.highlight code');
      if (!codeElement) return;

      // Get the text content, excluding line numbers if present
      let codeText = '';

      // Check if this is a table-based code block (with line numbers)
      const table = codeElement.querySelector('table.rouge-table');
      if (table) {
        // Extract only the code column (second column)
        const codeLines = table.querySelectorAll('.rouge-code');
        codeText = Array.from(codeLines).map(function(line) {
          return line.textContent;
        }).join('');
      } else {
        // Simple code block without line numbers
        codeText = codeElement.textContent;
      }

      // Copy to clipboard
      navigator.clipboard.writeText(codeText).then(function() {
        // Show "Copied!" feedback
        const copyText = button.querySelector('.copy-text');
        const copiedText = button.querySelector('.copied-text');

        if (copyText) copyText.style.display = 'none';
        if (copiedText) copiedText.style.display = 'inline';

        // Reset after 2 seconds
        setTimeout(function() {
          if (copyText) copyText.style.display = 'inline';
          if (copiedText) copiedText.style.display = 'none';
        }, 2000);
      }).catch(function(err) {
        console.error('Failed to copy code: ', err);
      });
    });
  });
});
