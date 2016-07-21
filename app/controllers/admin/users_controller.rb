class Admin::UsersController < ApplicationController

  before_filter :authorized?

  def index
    @users = User.page(params[:page]).per(10)
    if authorized?
      render :index
    else
      redirect_to movies_path, alert: "You are not an administrator!"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, alert: "User has been deleted."
  end

  def authorized?
    current_user.admin
  end
end
