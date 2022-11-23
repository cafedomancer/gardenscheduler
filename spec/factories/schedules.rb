# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    association :user
    association :variety
    name {'テストスケジュール01'}
    # name { Faker::Lorem.characters(number: 5) }
  end
end
