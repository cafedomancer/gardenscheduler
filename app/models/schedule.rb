# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :variety
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true

  has_many :children, class_name: 'Schedule', dependent: :destroy
  belongs_to :parent, class_name: 'Schedule', foreign_key: 'schedule_id', optional: true, inverse_of: :children

  validates :user_id, :variety_id, presence: true
end
