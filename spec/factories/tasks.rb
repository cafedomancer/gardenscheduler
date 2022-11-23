# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    association :user
    association :schedule
    name {'作業名001'}
    date { Faker::Date.between(from: '2022-11-01', to: '2022-12-31') }
  end
end
