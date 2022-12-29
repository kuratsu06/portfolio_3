require 'rails_helper'

RSpec.feature "completes", type: :feature do
  describe '新規作成と更新' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:complete) { create(:complete, user_id: user.id) }

    scenario 'ログインしないと、一覧ページを見れない' do
      visit completes_path
      expect(current_path).not_to eq completes_path
      expect(current_path).to eq new_user_session_path
    end

    scenario 'ログインしたあと、新規作成ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit post_path(post)
      click_on "このリストを達成済みにする"
      expect(current_path).to eq new_complete_path
      fill_in 'complete[done]', with: Time.zone.today.strftime('%Y-%m-%d')
      fill_in 'complete[memo]', with: "MyText"
      choose 'complete[again]', with: "enough"
      choose 'complete[status]', with: "public"
      click_on "登録する"
      expect(complete.reload.done).to eq Time.zone.today
      expect(complete.reload.memo).to eq "MyText"
      expect(complete.reload.again).to eq "enough"
      expect(complete.reload.status).to eq "public"
    end

    scenario 'ログインしたあと、編集ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on "ログイン"
      expect(current_path).to eq root_path

      visit complete_path(complete)
      click_on "編集"
      expect(current_path).to eq edit_complete_path(complete)
      fill_in 'complete[done]', with: Time.zone.today.strftime('%Y-%m-%d')
      fill_in 'complete[memo]', with: "MyText"
      choose 'complete[again]', with: "enough"
      choose 'complete[status]', with: "public"
      click_on "更新する"
      expect(complete.reload.done).to eq Time.zone.today
      expect(complete.reload.memo).to eq "MyText"
      expect(complete.reload.again).to eq "enough"
      expect(complete.reload.status).to eq "public"
    end
  end
end
