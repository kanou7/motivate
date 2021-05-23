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
      # フォームに情報を入力する
      fill_in 'Text', with: @comment.text
      # 送信するとCommentモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Comment.count }.by(1)
      # 投稿の詳細ページにいることを確認する
      expect(current_path).to eq(tweet_path(@tweet))
      # 投稿の詳細ページには先ほど投稿した内容のコメントが存在することを確認する
      expect(page).to have_content(@comment.text)
      # 投稿ページには先ほどコメントしたユーザーの名前が存在することを確認する
      expect(page).to have_content(@user.name)
    end
  end
  context 'コメント投稿ができないとき' do
    it 'ログインしていないとコメント投稿ボタンが表示されない' do
      # トップページに遷移する
      visit root_path
      # 投稿の詳細ページに行く
      visit tweet_path(@tweet)
      # コメント投稿ボタンがないことを確認する
      expect(page).to have_no_css('a', class: 'comment-submit')
    end
  end
end