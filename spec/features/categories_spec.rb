require 'rails_helper'

RSpec.feature "categories", type: :feature do
  describe '新規作成と更新' do
    let(:user) { create(:user) }
    let(:category) { create(:category, user_id: user.id) }

    scenario 'ログインしたあと、新規作成ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit new_post_path
      click_on "カテゴリを作成する"
      expect(current_path).to eq new_category_path
      fill_in 'category[name]', with: "MyString"
      click_on "登録する"
      expect(category.reload.name).to eq "MyString"
    end

    scenario 'ログインしたあと、編集ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit new_category_path(category)
      click_on "MyString"
      expect(current_path).to eq edit_category_path(category)
      fill_in 'category[name]', with: "MyString"
      click_on "更新する"
      expect(category.reload.name).to eq "MyString"
    end
  end
end
