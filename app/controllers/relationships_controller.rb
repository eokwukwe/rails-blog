# frozen_string_literal: true

# RelationshipsController
class RelationshipsController < ApplicationController
  before_action :require_non_admin_user

  # Follow a user
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  # Unfollower a user
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  # Prevent an admin from following other users
  def require_non_admin_user
    if current_user.admin?
      flash[:danger] = 'Admin cannot follow or unfollow users'
      redirect_to users_path
    end
  end
end
