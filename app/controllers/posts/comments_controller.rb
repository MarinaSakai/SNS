class Posts::CommentsController < ApplicationController
  def new
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    Comment.create(create_params)
    redirect_to post_path(@post)
  end

  private
    def create_params
      params.require(:comment).permit(:content).merge(post_id: @post.id, user_id: current_user.id)
    end

end
