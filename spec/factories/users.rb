# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 6) }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
    prefecture_id { 47 }
  end
end
