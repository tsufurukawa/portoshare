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

  def sortable_link(name, column)
    css_class = column == sort_column ? "active" : nil
    raw("<li class=\"#{css_class}\">#{link_to name, params.merge(sort: column, page: nil), class: 'sort-link'}</li>")
  end
end
