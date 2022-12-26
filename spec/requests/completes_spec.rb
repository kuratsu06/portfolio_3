require 'rails_helper'

RSpec.describe "completes", type: :request do
  describe 'HTTPリクエスト /URL' do
    let(:user) { create(:user) }
    let!(:complete) { create(:complete, user_id: user.id) }
    let(:post) { create(:post) }

    before do
      sign_in user
    end

    context 'レスポンスが成功していること' do
      it 'index.html.erb' do
        get completes_path
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
      it 'new.html.erb' do
        get new_complete_path(post_id: post.id)
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
      it 'show.html.erb' do
        get complete_path(complete)
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
      it 'edit.html.erb' do
        get edit_complete_path(complete, post_id: post.id)
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
    end

    context '@completeが取得できていること' do
      it 'show.html.erb' do
        get complete_path(complete)
        expect(response.body).to include complete.done.strftime('%Y年%m月%d日')
        expect(response.body).to include complete.memo
      end
      it 'edit.html.erb' do
        get edit_complete_path(complete, post_id: post.id)
        expect(response.body).to include complete.done.strftime('%Y-%m-%d')
        expect(response.body).to include complete.memo
        expect(response.body).to include complete.again
        expect(response.body).to include complete.status
      end
    end
  end
end
