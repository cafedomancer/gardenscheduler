# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Tasks', type: :request do
  let(:user) { FactoryBot.create(:user, id: 1) }
  let(:variety) { FactoryBot.create(:variety, id: 1) }
  before do
    @schedule = FactoryBot.create(:schedule, id: 1, user_id: user.id, variety_id: variety.id, prefecture_id: 47)
    @task = FactoryBot.create(:task, schedule_id: @schedule.id, user_id: user.id, name: 'PH1の酸性土壌を作る')
  end

  describe 'GET /tasks/:id/edit' do
    it 'リクエストが成功すること' do
      sign_in user
      get edit_task_path(@task.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /tasks/:id/edit' do
    it 'ゲストはログイン画面にリダイレクトされること' do
      get edit_task_path(@task.id)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'PUT /tasks/:id' do
    it 'リクエストが成功したらスケジュールページにリダイレクトすること' do
      sign_in user
      put task_path(@task.id), params: { task: { plan_memo: 'やっぱりPH6で。' } }
      expect(response.status).to redirect_to schedule_url(@task.schedule)
    end
  end

  describe 'PUT /tasks/:id' do
    it 'ゲストはログイン画面にリダイレクトされること' do
      put task_path(@task.id), params: { task: { plan_memo: 'やっぱりPH6で。' } }
      expect(response.status).to redirect_to new_user_session_path
    end
  end
end
