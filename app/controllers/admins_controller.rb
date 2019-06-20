class AdminsController < ApplicationController
  before_action :authenticate_admin

  def index_users
    @users = User.all
    @level = User.find_by(id: current_user)
  end

end
