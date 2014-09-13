module ApplicationHelper
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    extensions = {
      autolink: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true
    }

    find_and_preserve(Redcarpet::Markdown.new(renderer, extensions).render(text)).html_safe
  end

  def format_time(time)  # 2014-05-08 06:52:32 => 05/08/2014
    time.strftime("%m/%d/%Y")          
  end
end
