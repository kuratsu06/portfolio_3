require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Category Modelのテスト' do
    let(:category) { create(:category) }
    let(:user) { create(:user) }

    context 'バリテーションのテスト' do
      it 'user_id, nameがあれば有効であること' do
        expect(category).to be_valid
      end
      it 'user_idがなければ無効であること' do
        category.user_id = nil
        expect(category.valid?).to eq(false)
      end
      it 'nameがなければ無効であること' do
        category.name = nil
        expect(category.valid?).to eq(false)
      end
    end
  end
end
