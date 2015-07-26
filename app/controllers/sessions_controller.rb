class SessionsController < ApplicationController
  def new
  end
  
  def index
    if !current_user
      redirect_to log_in_path
    else
      @listitem = ListItem.new
      @listitems = ListItem.where(user: current_user.id).order(:index)
    end
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to logged_in_path
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to log_in_path, :notice => "Logged out!"
  end
end
