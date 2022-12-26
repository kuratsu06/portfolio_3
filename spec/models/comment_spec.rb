require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment Modelのテスト' do
    let(:comment) { create(:comment) }
    let(:user) { create(:user) }
    let(:complete) { create(:complete) }

    context 'バリテーションのテスト' do
      it 'user_id, complete_id, contentがあれば有効であること' do
        expect(comment).to be_valid
      end
      it 'user_idがなければ無効であること' do
        comment.user_id = nil
        expect(comment.valid?).to eq(false)
      end
      it 'complete_idがなければ無効であること' do
        comment.complete_id = nil
        expect(comment.valid?).to eq(false)
      end
      it 'contentがなければ無効であること' do
        comment.content = nil
        expect(comment.valid?).to eq(false)
      end
      it "contentが50文字以内である場合、有効であること" do
        comment.content = "1" * 50
        expect(comment).to be_valid
      end
      it "contentが51文字以上である場合、無効であること" do
        comment.content = "1" * 51
        expect(comment.valid?).to eq(false)
      end
    end
  end
end
