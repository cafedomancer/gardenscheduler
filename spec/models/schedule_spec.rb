# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scheduleモデル', type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:variety) { FactoryBot.create(:variety) }
  describe 'バリデーション' do
    it 'ユーザー、品種がある場合、有効である' do
      schedule = Schedule.new(
        user_id: user.id,
        variety_id: variety.id
      )
      expect(schedule).to be_valid
    end

    it 'ユーザーがない場合、無効である' do
      schedule = Schedule.new(
        variety_id: variety.id
      )
      expect(schedule).to_not be_valid
    end

    it '品種がない場合、無効である' do
      schedule = Schedule.new(
        user_id: user.id
      )
      expect(schedule).to_not be_valid
    end
  end
end
