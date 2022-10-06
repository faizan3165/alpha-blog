class UsersController < ApplicationController
  before_action :user_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}"

      redirect_to articles_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
