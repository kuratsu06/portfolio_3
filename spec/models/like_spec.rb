require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Like Modelのテスト' do
    let(:like) { create(:like) }
    let(:user) { create(:user) }
    let(:complete) { create(:complete) }

    context 'バリテーションのテスト' do
      it 'user_id, complete_idがあれば有効であること' do
        expect(like).to be_valid
      end
      it 'user_idがなければ無効であること' do
        like.user_id = nil
        expect(like.valid?).to eq(false)
      end
      it 'complete_idがなければ無効であること' do
        like.complete_id = nil
        expect(like.valid?).to eq(false)
      end
    end
  end
end
