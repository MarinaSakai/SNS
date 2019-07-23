# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = User.find_by(id: current_user)
    # フォローしている人たちのリスト
    @follows = Follow.select('target_user_id').where(user_id: current_user)
    # TL
    @posts_all = Post.where(scope_of_disclosure: 'everyone') # 公開範囲をeveryoneとしている全ての投稿
                     .or(Post.where(user_id: current_user)
                          .where.not(scope_of_disclosure: 'everyone')) # 自分の投稿(everyone以外)
                     .or(Post.where(user_id: @follows)
                          .where(scope_of_disclosure: 'followers'))
                     .order(created_at: 'desc')
                     .includes(:post_photos)
  end

  def follows
    @user = User.find_by(id: current_user)
    # フォローしている人たちのリスト
    @follows = Follow.select('target_user_id').where(user_id: current_user)
    @posts_follows = Post.where(user_id: @follows).where.not(scope_of_disclosure: 'self').order(created_at: 'desc')
                         .includes(:post_photos)
  end

  def new
    @post = Post.new
    # @post.post_photos.build
    @post.post_photos.new
  end

  def create
    @post = Post.new(post_params)
    begin
      ActiveRecord::Base.transaction do
        photo_params[:post_photos_attributes]['0'][:image].each do |photo|
          @post.post_photos.new(image: photo)
        end
        @post.save!
      end
      redirect_to posts_path
    rescue ActiveRecord::RecordInvalid
      @post.post_photos = [] #0の状態に戻す
      @post.post_photos.new
      render 'new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @photos = PostPhoto.where(post_id: @post.id)
  end

  private

  def post_params
    params.require(:post).permit(:content, :scope_of_disclosure).merge(user_id: current_user.id)
  end

  def photo_params
    params.require(:post).permit(post_photos_attributes: [:image=>[]])
  end

end
