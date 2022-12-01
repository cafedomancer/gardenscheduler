# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :request do
  let(:user) { FactoryBot.create(:user, id: 1) }
  let(:variety) { FactoryBot.create(:variety, id: 1) }
  before do
    @schedule = FactoryBot.create(:schedule, id: 1, user_id: user.id, variety_id: variety.id, prefecture_id: 47)
  end

  describe 'GET /schedules' do
    it 'リクエストが成功すること' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /schedules/1' do
    it 'リクエストが成功すること' do
      get schedule_path(1)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /schedules/new' do
    it 'リクエストが成功すること' do
      sign_in user
      get new_schedule_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /schedules/new' do
    it 'ゲストはログイン画面にリダイレクトされること' do
      get new_schedule_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET /schedules/1/copy' do
    it 'リクエストが成功すること' do
      sign_in user
      get copy_schedule_path(1)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /schedules/1/edit' do
    it 'リクエストが成功すること' do
      sign_in user
      get edit_schedule_path(1)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /schedules/1/edit' do
    it 'ゲストはトップにリダイレクトされること' do
      get edit_schedule_path(1)
      expect(response).to redirect_to root_path
    end
  end

  describe 'POST /schedules' do
    it 'リクエストが成功したら、スケジュールが1件保存されていること' do
      sign_in user
      expected = expect do
        post schedules_path, params: { schedule: { name: 'バラ', user_id: user.id, variety_id: variety.id, prefecture_id: 47 } }
      end
      expected.to change(Schedule, :count).by(1)
    end
  end

  describe 'PUT /schedules/1' do
    it 'リクエストが成功したら、スケジュールに変更内容が保存されていること' do
      sign_in user
      put schedule_path(1, format: :json), params: { schedule: { name: 'バラ' } }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect('バラ').to eq json['name']
    end
  end

  describe 'PUT /schedules/1' do
    it 'パラメータが不正な場合は変更内容が保存されないこと' do
      sign_in user
      put schedule_path(1, format: :json), params: { schedule: { name: nil, variety_id: nil } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE /schedules/1' do
    it 'リクエストが成功したら、スケジュールが1件削除されていること' do
      sign_in user
      expected = expect do
        delete schedule_path(1)
      end
      expected.to change(Schedule, :count).by(-1)
    end
  end

  describe 'DELETE /schedules/1' do
    it 'ゲストはログイン画面にリダイレクトされること' do
      expect(delete(schedule_path(1))).to redirect_to(root_path)
    end
  end
end
