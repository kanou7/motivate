class UsersController < ApplicationController
  before_action :set_user, only: [:followings, :followers]

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |gestuser|
      gestuser.password = SecureRandom.urlsafe_base64
      gestuser.name = 'ゲスト'
      gestuser.job_id = 24
      gestuser.status_id = 12
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order('created_at DESC')
  end

  def likes
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:tweet_id)
    @tweets = Tweet.find(likes)
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
