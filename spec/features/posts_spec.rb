require 'rails_helper'

RSpec.feature "posts", type: :feature do
  describe '新規作成と更新' do
    let(:user) { create(:user) }
    let(:category) { create(:category, user_id: user.id) }
    let(:post) { create(:post, user_id: user.id) }

    scenario 'ログインしないと、一覧ページを見れない' do
      visit posts_path
      expect(current_path).not_to eq posts_path
      expect(current_path).to eq new_user_session_path
    end

    scenario 'ログインしたあと、新規作成ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit new_post_path(category_id: category.id)
      expect(current_path).to eq new_post_path
      fill_in 'post[title]', with: "MyString"
      fill_in 'post[memo]', with: "MyText"
      choose 'post[status]', with: "public"
      click_on "登録する"
      expect(post.reload.title).to eq "MyString"
      expect(post.reload.memo).to eq "MyText"
      expect(post.reload.status).to eq "public"
    end

    scenario 'ログインしたあと、編集ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit post_path(post)
      click_on "編集"
      expect(current_path).to eq edit_post_path(post)
      fill_in 'post[title]', with: "MyString"
      fill_in 'post[memo]', with: "MyText"
      choose 'post[status]', with: "public"
      click_on "更新する"
      expect(post.reload.title).to eq "MyString"
      expect(post.reload.memo).to eq "MyText"
      expect(post.reload.status).to eq "public"
    end
  end
end
