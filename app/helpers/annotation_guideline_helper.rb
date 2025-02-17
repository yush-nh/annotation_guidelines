module AnnotationGuidelineHelper
  def md2html(text)
    html = Commonmarker.to_html(
      text,
      options: { render: { unsafe: true } },
      plugins: { syntax_highlighter: { theme: "InspiredGitHub" } }
    )

    raw(html)
  end
end
