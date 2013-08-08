class CommentsController < ApplicationController
  before_action :check_user_login

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = Tweet.find(params[:tweet_id])
    @comment.author = @current_user
    @comment.save

    redirect_to @comment.commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
