class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :move_to_index, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all.order('created_at DESC')
    @recommend_tweets = Tweet.where(status_id: current_user[:status_id]).limit(3).order('created_at DESC') if user_signed_in?
    @rank_tweets = Tweet.find(Like.group(:tweet_id).order('count(tweet_id) DESC').limit(5).pluck(:tweet_id))
    @tweet_statuses = Status.find(Tweet.group(:status_id).order('count_all DESC').limit(5).count.to_a)
    @tweet_jobs = Job.find(Tweet.group(:job_id).order('count_all DESC').limit(5).count.to_a)
  end

  def new
    @tweet = TweetsTag.new
  end

  def create
    @tweet = TweetsTag.new(tweet_params)
    tag_list = params[:tweets_tag][:name].split(',')
    if @tweet.valid?
      @tweet.save(tag_list)
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
    @form = TweetsTag.new(title: @tweet.title, text: @tweet.text, image: @tweet.image, job_id: @tweet.job_id, status_id: @tweet.status_id)
  end

  def update
    @tweet = TweetsTag.new(update_params)
    tag_list = params[:tweet][:name].split(',')
    if @tweet.valid?
      @tweet.update(tag_list)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  def search_tag
    relations = TweetTagRelation.where(tag_id: params[:tag])
    @tag_tweets = []
    relations.each do |relation|
      @tag_tweets << Tweet.find_by(id: relation.tweet_id)
    end
  end

  def searchIncre_tag
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json:{ keyword: tag }
  end

  def search_tags
    @tags = Tag.search(params[:keyword])
  end

  private

  def move_to_index
    redirect_to action: :index if current_user.id != @tweet.user.id
  end

  def tweet_params
    params.require(:tweets_tag).permit(:title, :image, :text, :job_id, :status_id, :name).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:tweet).permit(:title, :image, :text, :job_id, :status_id, :name).merge(user_id: current_user.id, tweet_id: params[:id])
  end

  def set_item
    @tweet = Tweet.find(params[:id])
  end
end
