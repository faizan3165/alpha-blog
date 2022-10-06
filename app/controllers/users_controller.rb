class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :requier_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update], :delete

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def show
    @articles = @user.articles
  end

  def create
    @user = User.create(user_params)

    if @user.save
      session[:user_id] = @user.id

      flash[:notice] = "Welcome to Alpha Blog #{@user.username}"

      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update(user_params)

    if @user.save
      flash[:notice] = "User updated successfully."

      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy

    session[:user_id] = nil && @user == current_user

    if @user.destroy
      flash[:notice] = "User deleted successfully."

      redirect_to articles_path
    else
      flash[:notice] = "Something went wrong."
      redirect_to users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && != current_user.admin?
      flash[:alert] = "You are not the current user or admin, hence are not allowed to perform this action"

      redirect_to @user
    end
  end
end
