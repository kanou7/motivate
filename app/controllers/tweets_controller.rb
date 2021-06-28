class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :move_to_index, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all.order('created_at DESC')
    @recommend_tweets = Tweet.where(status_id: current_user[:status_id]).limit(3).order('created_at DESC') if user_signed_in?
    @rank_tweets = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) DESC').limit(5).pluck(:tweet_id))
    @tweet_statuses = Status.find(Tweet.group(:status_id).order('count_all DESC').limit(5).count.to_a)
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

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet.id)
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  private

  def move_to_index
    redirect_to action: :index if current_user.id != @tweet.user.id
  end

  def tweet_params
    params.require(:tweet).permit(:title, :image, :text, :job_id, :status_id).merge(user_id: current_user.id)
  end

  def set_item
    @tweet = Tweet.find(params[:id])
  end
end
