# frozen_string_literal: true

# UsersController
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin_and_same_user, only: %i[destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
                 .order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to  the Alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Account updated successfully.'
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page],
                                             per_page: 6)
                          .order('created_at DESC')
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and user's articles have been deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can only edit your own account'
      redirect_to root_path
    end
  end

  def require_admin_and_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'Only admin or account owners can perform that action'
      redirect_to root_path
    end
  end
end
