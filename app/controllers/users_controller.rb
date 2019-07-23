# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    # 見たい人
    @user = User.find_by(id: params[:id])
    # 自分のプロフィール
    if @user == current_user
      @posts = Post.where(user_id: @user).order(created_at: 'desc')
                   .includes(:post_photos).includes(:user).includes(:favs_posts)
    # 他人のプロフィール
    else
      # 自分がフォローしている人だったら公開範囲がフォロワーの投稿も表示
      @posts = if Follow
                  .find_by(user_id: current_user, target_user_id: @user.id)
                 Post.where(user_id: @user)
                     .where(scope_of_disclosure: 'everyone')
                     .or(Post.where(user_id: @user)
                                   .where(scope_of_disclosure: 'followers'))
                     .order(created_at: 'desc')
                     .includes(:post_photos)
                     .includes(:user).includes(:favs_posts)
               else
                 Post.where(user_id: @user)
                     .where(scope_of_disclosure: 'everyone')
                     .order(created_at: 'desc')
                     .includes(:post_photos)
                     .includes(:user).includes(:favs_posts)
               end
    end
  end

  def edit
    @user = User.find_by(id: current_user)
  end

  def update
    @user = User.find_by(id: current_user)
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]

    if params[:user][:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:user][:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
end
