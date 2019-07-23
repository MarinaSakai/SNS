# frozen_string_literal: true
module Admins
  class UsersController < ApplicationController

    def index
      @users = User.all
      @level = current_user.level
    end

    def show
      @user = User.find_by(id: params[:id])
      @posts = Post.where(user_id: params[:id]).order(created_at: 'desc')
                   .includes(:user).includes(:post_photos)
    end
  end
end
