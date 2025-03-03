module ApplicationHelper
  def sort_by(column, label: nil)
    label ||= column
    direction = @sort_column == column && @sort_direction == "asc" ? "desc" : "asc"

    link_to "#{label} #{sort_icon(column)}".html_safe, notes_path(sort_column: column, sort_direction: direction)
  end

  private

  def sort_icon(column)
    if @sort_column == column.to_s
      if @sort_direction == "asc"
        content_tag(:i, "", class: "fas fa-sort-up")
      elsif @sort_direction == "desc"
        content_tag(:i, "", class: "fas fa-sort-down")
      end
    end
  end
end
