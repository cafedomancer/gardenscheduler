# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  describe '[Schedulesコントローラー]' do
    before do
      @user = FactoryBot.create(:user)
      @variety = FactoryBot.create(:variety, id: 1)
      @schedule = FactoryBot.create(:schedule, id: 1, user_id: @user.id, variety_id: @variety.id, prefecture_id:47)
      @task = FactoryBot.create(:task, schedule_id: @schedule.id, user_id: @user.id, name: '酸性土壌を作れ')
    end

    context 'ゲストがアクセスする' do
      it 'スケジュール一覧が表示される' do
        get '/schedules'
        expect(response.body).to include 'みんなの栽培スケジュール'
        expect(response.body).to include 'とうだいのひまわり'
        expect(response.body).not_to include '酸性土壌を作れ'
      end
      it 'スケジュール詳細が表示される' do
        get '/schedules/1'
        expect(response.body).to include 'とうだいのひまわり'
        expect(response.body).to include '酸性土壌を作れ'
      end
      it 'コピーリンクが表示されない' do
        get '/schedules/1'
        expect(response.body).not_to include 'このスケジュールをコピー'
      end
      it '編集ボタンが表示されない' do
        get '/schedules/1'
        expect(response.body).not_to include '編集'
      end
      it 'スケジュール作成画面が表示されない' do
        get '/schedules/new'
        expect(response).to redirect_to('/users/sign_in')
      end
      it 'スケジュール編集画面が表示されない' do
        get '/schedules/1/edit'
        expect(response).to redirect_to('/')
      end
    end

    context 'ユーザーがアクセスする' do
      it 'スケジュール一覧が表示される' do
        sign_in @user
        get '/schedules'
        expect(response.body).to include 'とうだいのひまわり'
        expect(response.body).not_to include '酸性土壌を作れ'
      end
      it 'スケジュール詳細が表示される' do
        sign_in @user
        get '/schedules/1'
        expect(response.body).to include 'とうだいのひまわり'
        expect(response.body).to include '酸性土壌を作れ'
      end
      it 'コピーリンクが表示される' do
        sign_in @user
        get '/schedules/1'
        expect(response.body).to include 'このスケジュールをコピー'
      end
      it '編集ボタンが表示される' do
        sign_in @user
        get '/schedules/1'
        expect(response.body).to include '編集'
      end
      it 'スケジュール作成画面が表示される' do
        sign_in @user
        get '/schedules/new'
        expect(response.body).to include 'スケジュール作成'
      end
      it 'スケジュール編集画面が表示される' do
        sign_in @user
        get '/schedules/1/edit'
        expect(response.body).to include 'スケジュール編集'
      end
    end

    context 'スケジュールのCRUD' do
      it 'スケジュールをCREATEできる' do
        FactoryBot.create(:variety, id: 2, name: 'そこらへんの草')

        sign_in @user
        visit root_path
        expect(page).to have_content '今後の予定作業'
        expect(page).to have_content '作成'
        click_link('作成')

        expect(page).to have_content 'スケジュール作成'
        fill_in('schedule[name]', with: 'テストの畑')
        select('和歌山県', from: 'schedule[prefecture_id]')
        select('そこらへんの草', from: 'schedule[variety_id]')
        click_on('登録する')

        expect(page).to have_content 'スケジュールを登録しました。'
        expect(page).to have_content 'そこらへんの草(テストの畑)@和歌山県'
      end

      it 'スケジュールをEDIT/UPDATEできる' do
        FactoryBot.create(:variety, id: 3, name: 'あっちの花')
        sign_in @user
        visit schedules_path
        expect(page).to have_content 'みんなの栽培スケジュール'
        expect(page).to have_content 'とうだいのひまわり@沖縄県'
        click_link('とうだいのひまわり@沖縄県')
        click_link('編集')
        expect(page).to have_content 'スケジュール編集'

        fill_in('schedule[name]', with: '試験中の畑')
        select('三重県', from: 'schedule[prefecture_id]')
        select('あっちの花', from: 'schedule[variety_id]')
        click_on('更新する')

        expect(page).to have_content 'スケジュールを更新しました。'
        expect(page).to have_content 'あっちの花(試験中の畑)@三重県'
      end

      it 'スケジュールをDESTROYできる', js: true do
        sign_in @user
        visit schedules_path
        expect(page).to have_content 'みんなの栽培スケジュール'
        expect(page).to have_content 'とうだいのひまわり@沖縄県'
        click_link('とうだいのひまわり@沖縄県')
        click_link('削除')
        page.accept_confirm do
          click_link 'OK'
        end
        expect(page).to have_content 'スケジュールを削除しました。'
        expect(page).not_to have_content 'あっちの花(試験中の畑)@三重県'
      end

    end
  end
end
