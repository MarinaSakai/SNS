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
                     .includes(:user).includes(:favs_posts)
  end

  def follows
    @user = User.find_by(id: current_user)
    # フォローしている人たちのリスト
    @follows = Follow.select('target_user_id').where(user_id: current_user)
    @posts_follows = Post.where(user_id: @follows).where.not(scope_of_disclosure: 'self').order(created_at: 'desc')
                         .includes(:post_photos)
                         .includes(:user).includes(:favs_posts)
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
        if photo_params[:post_photos_attributes] != nil
          photo_params[:post_photos_attributes]['0'][:image].each do |photo|
            @post.post_photos.new(image: photo)
          end
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
    @image = User.select("image_name").find_by(id: @post.user_id)
    @user = User.select("name").find_by(id: @post.user_id)
    @fav_post = FavsPost.find_by(post_id: @post.id, user_id: current_user.id)
    @favs_count = FavsPost.where(post_id: @post.id).count
    @comments = @post.comments.includes(:favs_comments).includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(:content, :scope_of_disclosure).merge(user_id: current_user.id)
  end

  def photo_params
    params.require(:post).permit(post_photos_attributes: [:image=>[]])
  end

end
