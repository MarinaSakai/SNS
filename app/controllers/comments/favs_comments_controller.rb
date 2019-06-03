class Comments::FavsCommentsController < ApplicationController
  before_action :save_previous_url

  def create
    @fav_comment = FavsComment.new(comment_id: params[:comment_id], user_id: current_user.id)
    @fav_comment.save
    @back_url = session[:previous_url]

    redirect_to @back_url
  end

  def destroy
    @fav_comment = FavsComment.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @fav_comment.destroy
    @back_url = session[:previous_url]
    redirect_to @back_url
  end

  def save_previous_url
    session[:previous_url] = URI(request.referer || '').path
  end
end
