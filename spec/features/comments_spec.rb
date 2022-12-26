require 'rails_helper'

RSpec.feature "comments", type: :feature do
  describe '新規作成' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:complete) { create(:complete) }

    scenario 'ログインしたあと、新規作成ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit complete_path(complete)
      fill_in 'comment[content]', with: "MyText"
      click_on "送信"
      expect(page).to have_content "MyText"
    end
  end
end
