# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_user?, :commenter

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def commenter(id)
    User.find(id)
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'Please login to proceed'
      redirect_to root_path
    end
  end

  def require_non_admin_user
    if current_user.admin?
      flash[:danger] = 'Unauthorised Admin action'
      redirect_to root_path
    end
  end
end
