require 'rails_helper'

RSpec.describe Complete, type: :model do
  describe 'Complete Modelのテスト' do
    let(:complete) { create(:complete) }
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context 'バリテーションのテスト' do
      it 'user_id, post_id, done, again, statusがあれば有効であること' do
        expect(complete).to be_valid
      end
      it 'user_idがなければ無効であること' do
        complete.user_id = nil
        expect(complete.valid?).to eq(false)
      end
      it 'post_idがなければ無効であること' do
        complete.post_id = nil
        expect(complete.valid?).to eq(false)
      end
      it 'doneがなければ無効であること' do
        complete.done = nil
        expect(complete.valid?).to eq(false)
      end
      it 'againがなければ無効であること' do
        complete.again = nil
        expect(complete.valid?).to eq(false)
      end
      it 'statusがなければ無効であること' do
        complete.status = nil
        expect(complete.valid?).to eq(false)
      end
    end

    context "検索機能のテスト" do
      it "検索文字列に完全一致する結果を表示すること" do
        expect(Complete.search("MyText")).to include(complete)
      end
      it "検索文字列に部分一致する結果を表示すること" do
        expect(Complete.search("M")).to include(complete)
      end
      it "検索文字列が一致しない場合、何も表示しないこと" do
        expect(Complete.search("あ")).to be_empty
      end
      it "検索文字列が空白の場合、全て表示すること" do
        expect(Complete.search("")).to include(complete)
      end
    end
  end
end
