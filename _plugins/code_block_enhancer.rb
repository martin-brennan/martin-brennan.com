# _plugins/code_block_enhancer.rb
require "nokogiri"

module Jekyll
  module CodeBlockEnhancer
    def self.language_display_name(lang_class)
      return nil unless lang_class
      match = lang_class.match(/language-(\w+)/)
      return nil unless match
      lang = match[1]

      {
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
      }[
        lang.downcase
      ] || lang.capitalize
    end

    def self.enhance_code_blocks(content)
      # Fast bail-out: only bother if the marker class appears
      return content unless content.include?("highlighter-rouge")

      # Prefer HTML5 parser if available; fall back to HTML
      fragment =
        if defined?(Nokogiri::HTML5)
          Nokogiri::HTML5.fragment(content)
        else
          Nokogiri::HTML::DocumentFragment.parse(content)
        end

      fragment
        .css("div.highlighter-rouge")
        .each do |highlighter_div|
          lang_class =
            highlighter_div["class"]&.split&.find do |c|
              c.start_with?("language-")
            end
          next unless (display_name = language_display_name(lang_class))
          if highlighter_div.children.any? { |child|
               child["class"]&.include?("code-block-header")
             }
            next
          end

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

          highlighter_div.prepend_child(
            (
              if defined?(Nokogiri::HTML5)
                Nokogiri::HTML5.fragment(header_html)
              else
                Nokogiri::HTML::DocumentFragment.parse(header_html)
              end
            )
          )
        end

      # Serialize as HTML (only used for .html pages due to the guard below)
      fragment.to_html
    end
  end
end

Jekyll::Hooks.register %i[posts pages documents], :post_render do |doc|
  # Only touch HTML outputs; leave XML/JSON/etc. alone
  next unless doc.output_ext == ".html"

  # Optional per-page opt-out: add `code_block_enhancer: false` in front matter
  next if doc.data["code_block_enhancer"] == false

  begin
    doc.output = Jekyll::CodeBlockEnhancer.enhance_code_blocks(doc.output)
  rescue => e
    Jekyll.logger.warn "CodeBlockEnhancer:",
                       "skipping #{doc.relative_path} (#{e.class}: #{e.message})"
  end
end
