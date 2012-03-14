module ApplicationHelper
  def icon_arrow_right
    content_tag :i, "", class: "icon-arrow-right"
  end
  
  def markdown text
    markdown_options = {autolink: true, no_intra_emphasis: true, fenced_code_blocks: true, gh_blockcode: true}
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, markdown_options)
    markdown.render(text).html_safe
  end
end
