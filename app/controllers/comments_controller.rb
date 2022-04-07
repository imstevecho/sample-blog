class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_comment, only: %i[show destroy]

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    post = Post.find(params[:post_id])
    CreateComment.new(post: post, author: current_user, params: comment_params).call

    redirect_to post_path(post), notice: 'Comment was successfully created.'
  rescue StandardError => e
    redirect_to post_path(post), flash: { error: e.message }
  end

  def destroy
    post = @comment.post
    @comment.destroy

    redirect_to post_path(post), notice: 'Comment was successfully destroyed.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
