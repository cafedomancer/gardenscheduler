# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Taskモデル', type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:schedule) { FactoryBot.create(:schedule) }
  describe 'バリデーション' do
    it 'ユーザー、スケジュールがある場合、有効である' do
      task = Task.new(
        user_id: user.id,
        schedule_id: schedule.id
      )
      expect(task).to be_valid
    end

    it 'ユーザーがない場合、無効である' do
      task = Task.new(
        schedule_id: schedule.id
      )
      expect(task).to_not be_valid
    end

    it 'スケジュールがない場合、無効である' do
      task = Task.new(
        user_id: user.id
      )
      expect(task).to_not be_valid
    end
  end
end
