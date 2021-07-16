require 'rails_helper'
RSpec.describe 'コメント投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
    @comment = FactoryBot.build(:comment)
  end
  
  context 'コメント投稿ができるとき' do
    it 'ログインしたユーザーはコメント投稿できる' do
      # ログインする
      sign_in(@user)
      # トップページに@tweetの詳細画面へのリンクがあることを確認する
      expect(page).to have_css('a', class: 'show-link'), href: tweet_path(@tweet)
      # 投稿詳細ページへ遷移する
      visit tweet_path(@tweet)
      # 入力欄が存在する
      expect(page).to have_css('textarea', class: 'comment-field')
      # 送信ボタンが存在する
      expect(page).to have_css('input', class: 'comment-submit')
    end
  end
  context 'コメント投稿ができないとき' do
    it 'ログインしていないとコメント投稿ボタンが表示されない' do
    # トップページに遷移する
    visit root_path
    # 投稿の詳細ページに行く
    visit tweet_path(@tweet)
    # コメントフォームがないことを確認する
    expect(page).to have_no_selector 'form'
    end
  end
end