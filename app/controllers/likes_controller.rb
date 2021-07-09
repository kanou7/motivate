class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like

  def create
    user = current_user
    Like.create(user_id: user.id, tweet_id: @tweet.id)
  end

  def destroy
    user = current_user
    like = Like.find_by(user_id: user.id, tweet_id: @tweet.id)
    like.destroy
  end

  private

  def set_like
    @tweet = Tweet.find(params[:tweet_id])
  end
end
