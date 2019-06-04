# frozen_string_literal: true

class FollowsController < ApplicationController
  def index_following
    @user = User.find_by(id: params[:id])
    @follows = Follow.where(user_id: @user.id)
  end

  def index_followers
    @user = User.find_by(id: params[:id])
    @followers = Follow.where(target_user_id: @user.id)
  end
end
