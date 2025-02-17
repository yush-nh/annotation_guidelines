module AnnotationGuidelineHelper
  def md2html(text)
    html = Commonmarker.to_html(text, plugins: { syntax_highlighter: { theme: "InspiredGitHub" } })
    raw(html)
  end
end
