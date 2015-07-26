class UsersController < ApplicationController
  def new
    @user = User.new
    if current_user
      redirect_to logged_in_path
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to log_in_path
    else
      render "new"
    end
  end
  
  def set_list_item_orderings
    
    listitems = ListItem.where(user: current_user.id)
    for listItem in listitems
      listItem.index = params[listItem.label]
      listItem.save
    end
    
    @listitems = ListItem.where(user: current_user.id).order(:index)
    
    redirect_to logged_in_path
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
end
