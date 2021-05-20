class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to :root
    else
      render new_tweet_path
    end
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def tweet_params
    params.require(:tweet).permit(:title, :image, :text, :job_id, :status_id).merge(user_id: current_user.id)
  end
end
