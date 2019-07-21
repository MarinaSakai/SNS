class TopController < ApplicationController

  def top
    if current_user
      redirect_to root_path
    end
    @posts = Post.where(scope_of_disclosure: 'everyone').order(created_at: 'desc')
  end
end
