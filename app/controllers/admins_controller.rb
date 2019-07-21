class AdminsController < ApplicationController
  before_action :authenticate_admin

  def index_users
    @users = User.all
    @level = current_user
  end

  def user_info
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: params[:id]).order(created_at: 'desc')
  end

end
