# frozen_string_literal: true

class Variety < ApplicationRecord
  has_many :schedules, dependent: :destroy
  belongs_to :user
  validates :user_id, :name, presence: true
end
