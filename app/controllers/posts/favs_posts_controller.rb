# frozen_string_literal: true

class Posts::FavsPostsController < ApplicationController
  before_action :save_previous_url

  def create
    @fav_post = FavsPost.new(post_id: params[:post_id], user_id: current_user.id)
    @fav_post.save
    @back_url = session[:previous_url]
    redirect_to @back_url
  end

  def destroy
    @fav_post = FavsPost.find_by(post_id: params[:post_id], user_id: current_user.id)
    @fav_post.destroy
    @back_url = session[:previous_url]
    redirect_to @back_url
  end

  def save_previous_url
    session[:previous_url] = URI(request.referer || '').path
  end
end
