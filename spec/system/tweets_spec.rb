require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end
  context 'ツイート投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_css('a', class: 'tweet-btn')
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in '作品名', with: @tweet.title
      attach_file('画像', 'public/images/sample.png', make_visible: true)
      fill_in '説明文', with: @tweet.text
      select '学生', from: 'tweet_job'
      select '中退', from: 'tweet_status'
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
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（職業、状況）
      expect(page).to have_content('学生')
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（状態、心境）
      expect(page).to have_content('中退')
    end
  end
  context 'ツイート投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_css('a', class: 'tweet-btn')
    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(page).to have_css('a', class: 'edit-btn'), href: edit_tweet_path(@tweet1)
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_title').value
      ).to eq(@tweet1.title)
      expect(
        find('#tweet_text').value
      ).to eq(@tweet1.text)
      expect(
        find('#tweet_job').value
      ).to eq(@tweet1.job_id.to_s)
      expect(
        find('#tweet_status').value
      ).to eq(@tweet1.status_id.to_s)
      # 投稿内容を編集する
      fill_in '作品名', with: 'テスト2'
      attach_file('画像', 'public/images/sample2.png', make_visible: true)
      fill_in '説明文', with: 'テストテスト2'
      select '専業主婦', from: 'tweet[job_id]'
      select '失恋', from: 'tweet[status_id]'
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Tweet.count }.by(0)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content('テスト2')
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='sample2.png']")
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content('テストテスト2')
      # トップページには先ほど変更した内容のツイートが存在することを確認する（職業、状況）
      expect(page).to have_content('専業主婦')
      # トップページには先ほど変更した内容のツイートが存在することを確認する（状態、心境）
      expect(page).to have_content('失恋')
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート2ユーザーでログインする
      sign_in(@tweet2.user)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link('a', class: 'edit-btn'), href: "/tweets/#{@tweet1.id}/edit"
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link('a', class: 'edit-btn'), href: "/tweets/#{@tweet1.id}/edit"
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link('a', class: 'edit-btn'), href: "/tweets/#{@tweet2.id}/edit"
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet, :tweet2)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # ツイート1に「削除」へのリンクがあることを確認する
      expect(page).to have_css('a', class: 'destroy-btn'), href: tweet_path(@tweet1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find('.destroy-btn').click
      end.to change { Tweet.count }.by(-1)
      # トップページ画面に遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のツイートが存在しないことを確認する（タイトル）
      expect(page).to have_no_content(@tweet1.title.to_s)
      # トップページには先ほど投稿した内容のツイートが存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='sample.png']")
      # トップページには先ほど投稿した内容のツイートが存在しないことを確認する（説明文）
      expect(page).to have_no_content(@tweet1.text.to_s)
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      sign_in(@tweet1.user)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link('a', class: 'destroy-btn'), href: "/tweets/#{@tweet1.id}/destroy"
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # ツイート1に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link('a', class: 'destroy-btn'), href: "/tweets/#{@tweet1.id}/destroy"
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link('a', class: 'destroy-btn'), href: "/tweets/#{@tweet2.id}/destroy"
    end
  end
end