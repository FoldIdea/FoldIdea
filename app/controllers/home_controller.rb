class HomeController < ApplicationController
  def index
    if current_user && session[:justloggedin]
      redirect_to profile_path(id: current_user.to_param)
      return
    end
  end

  def profile
    @user = User.find params[:id]
    @is_current_user = (current_user ? current_user.id : nil) == @user.id
    @welcome = @is_current_user && session[:justloggedin]
  end
end
