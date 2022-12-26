require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post Modelのテスト' do
    let(:post) { create(:post) }
    let(:user) { create(:user) }
    let(:category) { create(:category) }

    context 'バリテーションのテスト' do
      it 'user_id, category_id, title, statusがあれば有効であること' do
        expect(post).to be_valid
      end
      it 'user_idがなければ無効であること' do
        post.user_id = nil
        expect(post.valid?).to eq(false)
      end
      it 'category_idがなければ無効であること' do
        post.category_id = nil
        expect(post.valid?).to eq(false)
      end
      it 'titleがなければ無効であること' do
        post.title = nil
        expect(post.valid?).to eq(false)
      end
      it "titleが10文字以内である場合、有効であること" do
        post.title = "1" * 10
        expect(post).to be_valid
      end
      it "titleが11文字以上である場合、無効であること" do
        post.title = "1" * 21
        expect(post.valid?).to eq(false)
      end
      it 'statusがなければ無効であること' do
        post.status = nil
        expect(post.valid?).to eq(false)
      end
    end

    context "検索機能のテスト" do
      it "検索文字列に完全一致する結果を表示すること" do
        expect(Post.search("MyString")).to include(post)
      end
      it "検索文字列に部分一致する結果を表示すること" do
        expect(Post.search("M")).to include(post)
      end
      it "検索文字列が一致しない場合、何も表示しないこと" do
        expect(Post.search("あ")).to be_empty
      end
      it "検索文字列が空白の場合、全て表示すること" do
        expect(Post.search("")).to include(post)
      end
    end
  end
end
