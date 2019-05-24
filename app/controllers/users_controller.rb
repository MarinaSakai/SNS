class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:id])
    # 自分がフォローしている人たちのリスト
    @follows = Follow.select("target_user_id").where(user_id: current_user)

    # 自分のプロフィール
    if @user == current_user
      @posts = Post.where(user_id: @user)
    # 他人のプロフィール
    else
      # 自分がフォローしている人だったら公開範囲がフォロワーの投稿も表示
      if @follows.include?(@user)
        @posts = Post.where.not(scope_of_disclosure: "self")
      else
        @posts = Post.where(scope_of_disclosure: "everyone")
      end
    end
  end
  
end
