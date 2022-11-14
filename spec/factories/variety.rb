# frozen_string_literal: true

FactoryBot.define do
  factory :variety do
    association :user
    name { Faker::Lorem.characters(number: 5) }
  end
end
