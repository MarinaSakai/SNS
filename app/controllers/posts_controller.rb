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
  end

  def follows
    @user = User.find_by(id: current_user)
    # フォローしている人たちのリスト
    @follows = Follow.select('target_user_id').where(user_id: current_user)
    @posts_follows = Post.where(user_id: @follows).where.not(scope_of_disclosure: 'self').order(created_at: 'desc')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content, :scope_of_disclosure, images: []).merge(user_id: current_user.id)
  end
end
