# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  describe '[Schedulesコントローラー]' do
    before do
      @user = FactoryBot.create(:user)
      @variety = FactoryBot.create(:variety, id: 1)
      @schedule = FactoryBot.create(:schedule, id: 1, user_id: @user.id, variety_id: @variety.id)
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
  end
end
