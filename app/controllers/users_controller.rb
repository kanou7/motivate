class UsersController < ApplicationController
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
  end
end
