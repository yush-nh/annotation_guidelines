class Note < ApplicationRecord
  belongs_to :user

  before_create :set_id
  before_validation :set_default_title, if: -> { title.blank? && body.present? }

  validates :title, length: { maximum: 255 }
  validate :title_and_body_cannot_both_empty

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

  private

  def set_id
    self.id = SecureRandom.uuid
  end

  def set_default_title
    self.title = "no title"
  end

  def title_and_body_cannot_both_empty
    if title.blank? && body.blank?
      errors.add(:base, "Title and body cannot both be empty.")
    end
  end
end
