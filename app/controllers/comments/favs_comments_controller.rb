class Comments::FavsCommentsController < ApplicationController

  def create
    @fav_comment = FavsComment.new(comment_id: params[:comment_id], user_id: current_user.id)
    @fav_comment.save
    redirect_back(fallback_location: post_path(params[:post_id]))
  end

  def destroy
    @fav_comment = FavsComment.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @fav_comment.destroy
    redirect_back(fallback_location: post_path(params[:post_id]))
  end
end
