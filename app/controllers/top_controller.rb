class TopController < ApplicationController

  def top
    if current_user
      redirect_to posts_path
    end
    @posts = Post.where(scope_of_disclosure: 'everyone')
  end
end
