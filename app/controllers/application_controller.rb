class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    session[:justloggedin] = true
    super
  end

  def after_sign_up_path_for(resource)
    session[:justloggedin] = true
    profile_path(id: current_user.to_param)
  end

  def after_confirmation_path_for(resource_name, resource)
    session[:justloggedin] = true
    profile_path(id: current_user.to_param)
  end
end
