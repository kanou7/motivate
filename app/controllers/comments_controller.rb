class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comments = Comment.where(tweet_id: @tweet)
    @comment = Comment.create(comment_params)
    render :index
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = current_user.comments.find_by(tweet_id: @tweet)
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
