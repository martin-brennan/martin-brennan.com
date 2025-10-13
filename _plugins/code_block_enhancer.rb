require "nokogiri"

module Jekyll
  module CodeBlockEnhancer
    def self.language_display_name(lang_class)
      # Extract language from class like "language-ruby" or "language-javascript"
      return nil unless lang_class

      match = lang_class.match(/language-(\w+)/)
      return nil unless match

      lang = match[1]

      # Map language codes to display names
      language_map = {
        "js" => "JavaScript",
        "javascript" => "JavaScript",
        "rb" => "Ruby",
        "ruby" => "Ruby",
        "py" => "Python",
        "python" => "Python",
        "java" => "Java",
        "cpp" => "C++",
        "c" => "C",
        "cs" => "C#",
        "go" => "Go",
        "rust" => "Rust",
        "php" => "PHP",
        "html" => "HTML",
        "css" => "CSS",
        "scss" => "SCSS",
        "sass" => "Sass",
        "sql" => "SQL",
        "bash" => "Bash",
        "sh" => "Shell",
        "json" => "JSON",
        "yaml" => "YAML",
        "yml" => "YAML",
        "xml" => "XML",
        "markdown" => "Markdown",
        "md" => "Markdown",
        "ts" => "TypeScript",
        "typescript" => "TypeScript",
        "swift" => "Swift",
        "kotlin" => "Kotlin",
        "vim" => "Vim Script",
        "dockerfile" => "Dockerfile",
        "elixir" => "Elixir",
        "erlang" => "Erlang",
        "haskell" => "Haskell",
        "lua" => "Lua",
        "r" => "R",
        "scala" => "Scala"
      }

      language_map[lang.downcase] || lang.capitalize
    end

    def self.enhance_code_blocks(content)
      doc = Nokogiri::HTML::DocumentFragment.parse(content)

      doc
        .css("div.highlighter-rouge")
        .each do |highlighter_div|
          # Get the language from the class
          lang_class =
            highlighter_div["class"]
              .split(" ")
              .find { |c| c.start_with?("language-") }
          next unless lang_class

          display_name = language_display_name(lang_class)
          next unless display_name

          if highlighter_div.children.any? { |child|
               child["class"]&.include?("code-block-header")
             }
            next
          end

          # Create the header with language name and copy button
          header_html = <<~HTML
          <div class="code-block-header">
            <span class="code-block-language">#{display_name}</span>
            <button class="code-copy-button" aria-label="Copy code to clipboard">
              <svg class="copy-icon" width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M4 2H11L14 5V13C14 13.5523 13.5523 14 13 14H4C3.44772 14 3 13.5523 3 13V3C3 2.44772 3.44772 2 4 2Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M9 2V5H12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
              <span class="copy-text">Copy</span>
              <span class="copied-text" style="display:none;">Copied!</span>
            </button>
          </div>
        HTML

          # Insert the header before the highlight div
          highlighter_div.prepend_child(
            Nokogiri::HTML::DocumentFragment.parse(header_html)
          )
        end

      doc.to_html
    end
  end
end

Jekyll::Hooks.register %i[posts pages documents], :post_render do |doc|
  doc.output = Jekyll::CodeBlockEnhancer.enhance_code_blocks(doc.output)
end
