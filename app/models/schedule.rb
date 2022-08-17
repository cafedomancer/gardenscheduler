class Schedule < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :variety
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
