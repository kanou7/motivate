require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe '投稿の保存' do
    context '投稿が保存できる場合' do
      it 'textが存在するとき保存できる' do
        expect(@comment).to be_valid
      end
    end

    context '投稿が保存できない場合' do
      it 'textが空では登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include 'Textを入力してください'
      end
    end
  end
end
