class AnnotationGuideline < ApplicationRecord
  belongs_to :user

  validates :title, presence: :true, length: { maximum: 255 }

  # Commonmarker ensures that potentially dangerous tags like <script> are already sanitized.
  # However, Brakeman still raises a Cross-Site Scripting warning when the raw output of Commonmarker.to_html is used in views.
  # To suppress the warning, explicitly mark the returned HTML as safe using .html_safe.
  def html_body
    Commonmarker.to_html(
      body,
      options: { render: { unsafe: true } },
      plugins: { syntax_highlighter: { theme: "InspiredGitHub" } }
    ).html_safe
  end
end
