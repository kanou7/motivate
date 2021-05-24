require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  before do
  @user = FactoryBot.create(:user)
  @tweet = FactoryBot.create(:tweet)
  @like = FactoryBot.build(:like)
  end

  context 'いいねができるとき' do
    it 'ログインしたユーザーはいいねができる' do
      # ログインする
      sign_in(@user)
      # トップページにいいねボタンがあることを確認する
      expect(page).to have_css('a', class: 'like-btn'), href: tweet_likes_path(@tweet)
      # クリックするとLikeモデルのカウントが1上がることを確認する
      expect do
        find('a', class: 'like-btn').click
      end.to change { Like.count }.by(1)
      # トップページにいることを確認する
      expect(current_path).to eq(root_path)
      # トップページにいいね解除ボタンがあることを確認する
      expect(page).to have_css('a', class: 'delete-likeBtn')
    end
  end
  context 'いいねができないとき' do
    it 'ログインしていないといいねボタンが表示されない' do
      # トップページに遷移する
      visit root_path
      # トップページにいいねボタンがないことを確認する
      expect(page).to have_no_css('a', class: 'like-btn'), href: tweet_likes_path(@tweet)
    end
  end
  context 'いいね解除ができるとき' do
    it 'ログインしたユーザーでいいねした投稿に対していいね解除ができる' do
      # ログインする
      sign_in(@user)
      # トップページにいいねボタンがあることを確認する
      expect(page).to have_css('a', class: 'like-btn'), href: tweet_likes_path(@tweet)
      # クリックするとLikeモデルのカウントが1上がることを確認する
      expect do
        find('a', class: 'like-btn').click
      end.to change { Like.count }.by(1)
      # トップページにいることを確認する
      expect(current_path).to eq(root_path)
      # トップページにいいね解除ボタンがあることを確認する
      expect(page).to have_css('a', class: 'delete-likeBtn')
      # クリックするとLikeモデルのカウントが1下がることを確認する
      expect do
        find('a', class: 'like-btn').click
      end.to change { Like.count }.by(-1)
      # トップページにいることを確認する
      expect(current_path).to eq(root_path)
      # トップページにいいね解除ボタンがなくなっていることを確認する
      expect(page).to have_no_css('a', class: 'delete-likeBtn')
    end
  end

end