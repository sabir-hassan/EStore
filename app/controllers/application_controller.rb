class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User, fallback: :none
  

#  before_action :current_cart

  def current_cart
    @current_cart ||= ShoppingCart.new(token: current_user)
  end
  helper_method :current_cart

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

end
