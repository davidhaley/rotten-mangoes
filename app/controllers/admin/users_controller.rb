class Admin::UsersController < ApplicationController

  before_filter :authorized?

  def index
    @users = User.all
    if authorized?
      render :index
    else
      redirect_to movies_path, alert: "You are not an administrator!"
    end
  end

  def authorized?
    current_user.admin
  end
end
