class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create
    user = current_user
    tweet = Tweet.find(params[:tweet_id])
    like = Like.create(user_id: user.id, tweet_id: tweet.id)
    redirect_to root_path
  end

  def destroy
    user = current_user
    tweet = Tweet.find(params[:tweet_id])
    like = Like.find_by(user_id: user.id, tweet_id: tweet.id)
    like.destroy
    redirect_to root_path
  end

  private

  def set_like
    @tweet = Tweet.find(params[:tweet_id])
  end
end
