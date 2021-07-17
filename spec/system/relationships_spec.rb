require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  context 'ログインしたユーザーはフォロー、フォロー解除することができる' do
    it 'ユーザーをフォローできる' do 
      # @user1としてログイン           
      sign_in(@user1)

      # @user1としてユーザー一覧ページへ遷移する
      visit user_path(@user2)

      # @user2をフォローする
      expect do
      find('input', class: 'follow-btn').click
      end.to change { Relationship.count }.by(1)
    end
    it 'ユーザーフォロー解除できる' do
      # @user1としてログイン           
      sign_in(@user1)

      # @user1としてユーザー2ページへ遷移する
      visit user_path(@user2)

      # @user2をフォローする
      expect do
        click_button 'フォロー'
      end.to change { Relationship.count }.by(1)

      # @user1としてユーザー一覧ページへ遷移する
      visit user_path(@user2)

      # @user2をフォロー解除する
      expect do
        click_button 'フォロー解除'
      end.to change { Relationship.count }.by(-1)
    end
  end
end