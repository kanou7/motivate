require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ログインページに新規登録へ遷移するボタンがあることを確認する
      expect(page).to have_content('こちら')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '名前（6文字以下）', with: @user.name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      fill_in 'パスワード（確認用）', with: @user.password_confirmation
      select '学生', from: 'user[job_id]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_content('アカウント登録が完了しました。')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ移動する
      visit new_user_session_path
      # ログインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('こちら')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '名前（6文字以下）', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード（6文字以上）', with: ''
      fill_in 'パスワード（確認用）', with: ''
      select '--', from: 'user[job_id]'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # ログインしたことを確認する
      expect(page).to have_content('ログインしました。')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'ゲストログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ゲストログインができるとき' do
    it '保存されているゲストユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ゲストログインボタンを押す
      find('a[name="gest-submit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
      # ゲストログインしたことを確認する
      expect(page).to have_content('ゲストユーザーとしてログインしました。')
    end
  end
end
