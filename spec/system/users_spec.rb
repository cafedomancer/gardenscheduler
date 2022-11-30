# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  describe 'システムスペック' do
    let(:user) { FactoryBot.create(:user) }
    let(:variety) { FactoryBot.create(:variety, id: 1) }

    context 'ゲストがアクセスする' do
      it 'アカウント設定画面が表示されない' do
        get '/users/edit'
        expect(response).to redirect_to('/users/sign_in')
      end
      it 'ログイン画面が表示される' do
        visit new_user_session_path
        expect(page).to have_content 'LINEでログイン'
      end
    end

    context 'ユーザーがアクセスする' do
      it 'アカウント設定画面が表示される' do
        sign_in user
        visit edit_user_registration_path
        expect(page).to have_content 'アカウント設定'
      end
      it 'ログイン画面が表示されない' do
        sign_in user
        get '/users/sign_in'
        expect(response).to redirect_to('/')
      end
    end

    context 'アカウント設定' do
      it '名前が変更できる' do
        sign_in user
        visit edit_user_registration_path
        fill_in('user_name', with: 'キャンディス・ホワイト・アードレー')
        click_on('更新する')
        visit edit_user_registration_path
        expect(page).to have_field('user[name]', with: 'キャンディス・ホワイト・アードレー')
      end
      it '都道府県が変更できる' do
        sign_in user
        visit edit_user_registration_path
        select('宮城県', from: 'user_prefecture_id')
        click_on('更新する')
        visit edit_user_registration_path
        expect(page).to have_field('user_prefecture_id', with: '4')
      end
      it '通知時刻が変更できる' do
        sign_in user
        visit edit_user_registration_path
        select('22', from: 'user_notification_time')
        click_on('更新する')
        visit edit_user_registration_path
        expect(page).to have_field('user_notification_time', with: '22')
      end
      it 'アカウント削除ができる' do
        sign_in user
        visit edit_user_registration_path
        expect(page).to have_content 'アカウント削除'
        click_button('アカウント削除')
        expect {
          page.accept_confirm '本当によろしいですか？'
          expect(page).to have_content 'アカウントを削除しました。'
        }.to change { User.count }.by(-1)
      end
    end
  end
end
