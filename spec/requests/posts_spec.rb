require 'rails_helper'

RSpec.describe "posts", type: :request do
  describe 'HTTPリクエスト /URL' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }
    let(:category) { create(:category) }

    before do
      sign_in user
    end

    context 'レスポンスが成功していること' do
      it 'index.html.erb' do
        get posts_path
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
      it 'new.html.erb' do
        get new_post_path(category_id: category.id)
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
      it 'show.html.erb' do
        get post_path(post)
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
      it 'edit.html.erb' do
        get edit_post_path(post, category_id: category.id)
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
    end

    context '@postが取得できていること' do
      it 'show.html.erb' do
        get post_path(post)
        expect(response.body).to include post.title
        expect(response.body).to include post.memo
      end
      it 'edit.html.erb' do
        get edit_post_path(post, category_id: category.id)
        expect(response.body).to include post.title
        expect(response.body).to include post.memo
        expect(response.body).to include post.status
      end
    end
  end
end
