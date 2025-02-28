class UsersController < ApplicationController
  include Sortable

  SORT_COLUMNS = %w[title email updated_at]
  DEFAULT_SORT_COLUMN = "updated_at"
  SORT_DIRECTIONS = %w[asc desc]
  DEFAULT_SORT_DIRECTION = "desc"

  def show
    @user = User.find_by!(email: params[:email])
    @notes = @user.notes.order("#{sort_column}").page(params[:page])

    @sort_column = params[:sort_column]
    @sort_direction = params[:sort_direction]
  end
end
