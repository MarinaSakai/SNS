class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    # 自分がフォローしている人たちのリスト
    @follows = Follow.where(user_id: current_user)
    @follows_id = @follows.pluck(:target_user_id)
    # 自分のプロフィール
    if @user == current_user
      @posts = Post.where(user_id: @user)
    # 他人のプロフィール
    else
      # 自分がフォローしている人だったら公開範囲がフォロワーの投稿も表示

      if @follows_id.include?(@user.id)
        @posts = Post.where(user_id: @user).where(scope_of_disclosure: "everyone")
        .or(Post.where(user_id: @user).where(scope_of_disclosure: "followers"))
        .order(created_at: 'desc')
      else
        @posts = Post.where(user_id: @user).where(scope_of_disclosure: "everyone")
        .order(created_at: 'desc')
      end
    end
  end

  def edit
    @user = User.find_by(id: current_user)
  end
end
