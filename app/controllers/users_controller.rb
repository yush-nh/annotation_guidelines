class UsersController < ApplicationController
  def show
    @user = User.find_by!(email: params[:email])
    @notes = @user.notes.order(updated_at: :desc).page(params[:page])
  end
end
