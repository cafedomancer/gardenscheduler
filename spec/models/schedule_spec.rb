# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:variety) { FactoryBot.create(:variety) }

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

# t.text "name"
# t.integer "prefecture_id"
# t.integer "user_id", null: false
# t.integer "variety_id", null: false
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false
