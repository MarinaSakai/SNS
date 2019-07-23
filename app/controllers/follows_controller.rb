# frozen_string_literal: true

class FollowsController < ApplicationController
  def index_following
    @user = User.find_by(id: params[:id])
    @follows = Follow.where(user_id: @user.id).includes(:target_user)
  end

  def index_followers
    @user = User.find_by(id: params[:id])
    @followers = Follow.where(target_user_id: @user.id).includes(:user)
  end

  def create
    @follow = Follow.new(user_id: current_user.id, target_user_id: params[:user_id])
    @follow.save!
    redirect_to user_path(id: params[:user_id])
  end

  def destroy
    @follow = Follow.find_by!(id: params[:id], user_id: current_user.id)
    @follow.destroy
    redirect_to user_path(id: params[:user_id])
  end

end
