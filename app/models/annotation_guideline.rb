class AnnotationGuideline < ApplicationRecord
  belongs_to :user

  validates :title, presence: :true, length: { maximum: 255 }

  def html_body
    Commonmarker.to_html(
      body,
      options: { render: { unsafe: true } },
      plugins: { syntax_highlighter: { theme: "InspiredGitHub" } }
    )
  end
end
