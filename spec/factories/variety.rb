# frozen_string_literal: true

FactoryBot.define do
  factory :variety do
    association :user
    id { 1 }
    name { 'とうだいのひまわり' }
  end
end
