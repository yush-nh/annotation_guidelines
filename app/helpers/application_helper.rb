module ApplicationHelper
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
