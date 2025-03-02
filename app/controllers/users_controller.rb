class UsersController < ApplicationController
  def show
    @user = User.find_by!(email: params[:email])
    @notes = @user.notes
                  .includes(:user)
                  .order_by(params[:sort_column], params[:sort_direction])
                  .page(params[:page])

    @sort_column = params[:sort_column]
    @sort_direction = params[:sort_direction]
  end
end
