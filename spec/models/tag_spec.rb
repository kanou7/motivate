require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグの保存' do
    context 'タグが保存できる場合' do
      it 'nameが存在するとき保存できる' do
        expect(@tag).to be_valid
      end
    end

    context 'タグが空でもエラーが出ない' do
      it 'nameが空でもエラーが出ない' do
        expect(@tag).to be_valid
        @tag.name = ''
        @tag.valid?
      end
    end

  end
end
