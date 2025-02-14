class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user

  private

  # Set current_user until make login function.
  def current_user
    @current_user ||= User.first
  end
end
