# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Variety, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザー、名前がある場合、有効である' do
    variety = Variety.new(
      user_id: user.id,
      name: Faker::Lorem.characters(number: 10)
    )
    expect(variety).to be_valid
  end

  it 'ユーザーがない場合、無効である' do
    variety = Variety.new(
      name: Faker::Lorem.characters(number: 10)
    )
    expect(variety).to_not be_valid
  end

  it '名前がない場合、無効である' do
    variety = Variety.new(
      user_id: user.id
    )
    expect(variety).to_not be_valid
  end
end
