require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end
  context 'ツイート投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_css('a', class: "tweet-btn")
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in '作品名', with: @tweet.title
      attach_file('画像', 'public/images/sample.png', make_visible: true)
      fill_in '説明文', with: @tweet.text
      select '学生', from: 'tweet[job_id]'
      select '中退', from: 'tweet[status_id]'
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Tweet.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content(@tweet.title)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='sample.png']")
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（説明文）
      expect(page).to have_content(@tweet.text)
    end
  end
  context 'ツイート投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_css('a', class: "tweet-btn")
    end
  end
end
