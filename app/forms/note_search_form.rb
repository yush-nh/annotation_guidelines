class NoteSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :author, :string
  attribute :start_date, :date
  attribute :end_date, :date

  validate :end_date_cannot_be_before_start_date

  def search(base_scope = Note)
    notes = base_scope.includes(:user)
    return notes if invalid? # Exec validation to receiver instance.

    notes = filter_by_title(notes)
    notes = filter_by_author(notes)
    filter_by_updated_at(notes)
  end

  private

  def filter_by_title(notes)
    return notes unless title.present?

    notes.where("title LIKE ?", "%#{title}%")
  end

  def filter_by_author(notes)
    return notes unless author.present?

    notes.joins(:user).where("users.email LIKE ?", "%#{author}%")
  end

  def filter_by_updated_at(notes)
    notes = notes.where(updated_at: start_date..) if start_date.present?
    notes = notes.where(updated_at: ..end_date) if end_date.present?
    notes
  end

  def end_date_cannot_be_before_start_date
    return unless start_date.present? && end_date.present?

    errors.add(:base, "The 'Updated at' end date must be on or after the start date.") if end_date < start_date
  end
end
