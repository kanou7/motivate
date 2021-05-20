require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe '投稿の保存' do
    context '投稿が保存できる場合' do
      it 'title, text, job_id, status_idが存在するとき保存できる' do
        expect(@tweet).to be_valid
      end
      it 'job_id, status_idは1以外の時保存できる' do
        @tweet.job_id = 2
        @tweet.status_id = 2
        expect(@tweet).to be_valid
      end
    end

    context '投稿が保存できない場合' do
      it 'titleが空では登録できない' do
        @tweet.title = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include '作品名を入力してください'
      end
      it 'textが空では登録できない' do
        @tweet.text = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include '説明文を入力してください'
      end
      it 'job_idが空では登録できない' do
        @tweet.job_id = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include 'どんな職業、状況の人に見て欲しいかを入力してください'
      end
      it 'status_idが空では登録できない' do
        @tweet.status_id = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include 'どんな状態、心境の人に見て欲しいかを入力してください'
      end
      it 'job_idは1では登録できない' do
        @tweet.status_id = 1
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include 'どんな状態、心境の人に見て欲しいかを選択してください'
      end
      it 'status_idは1では登録できない' do
        @tweet.status_id = 1
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include 'どんな状態、心境の人に見て欲しいかを選択してください'
      end
    end
  end
end
