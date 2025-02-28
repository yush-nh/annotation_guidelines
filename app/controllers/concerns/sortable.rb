module Sortable
  extend ActiveSupport::Concern

  def sort_column
    columns = self.class::SORT_COLUMNS
    default_sort_column = self.class::DEFAULT_SORT_COLUMN
    directions = self.class::SORT_DIRECTIONS
    default_sort_direction = self.class::DEFAULT_SORT_DIRECTION


    if columns.include?(params[:sort_column]) && directions.include?(params[:sort_direction])
      if params[:sort_column] == "author"
        "users.email #{params[:sort_direction]}"
      else
        "#{params[:sort_column]} #{params[:sort_direction]}"
      end
    else
      "#{default_sort_column} #{default_sort_direction}"
    end
  end
end
