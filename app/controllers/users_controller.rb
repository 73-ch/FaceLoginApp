class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def login
    @user = User.new
  end

  def auth
    
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
