class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "You're signed up #{@user.username}!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def require_logged_out
    if logged_in?
      flash.now[:error] = "Please logout if you wish to sign up a new user"
      redirect_to root_path
    end
  end
end
