class TopController < ApplicationController

  def top
    if current_user
      redirect_to root_path
    end
    @posts = Post.where(scope_of_disclosure: 'everyone').order(created_at: 'desc')
                 .includes(:post_photos).includes(:user).includes(:favs_posts)
  end
end
