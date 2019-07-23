# frozen_string_literal: true

class Posts::FavsPostsController < ApplicationController

  def create
    @fav_post = FavsPost.new(post_id: params[:post_id], user_id: current_user.id)
    @fav_post.save
    redirect_back(fallback_location: post_path(params[:post_id]))
  end

  def destroy
    @fav_post = FavsPost.find_by(post_id: params[:post_id], user_id: current_user.id)
    @fav_post.destroy
    redirect_back(fallback_location: post_path(params[:post_id]))
  end

end
