class Task < ApplicationRecord
  belongs_to :schedule
  belongs_to :user

  has_one_attached :done_image1
  validate :verify_icon_type
  validates :user_id, :schedule_id, presence: true

  private

  def verify_icon_type
    return unless done_image1.attached?

    allowed_file_types = %w[image/jpg image/jpeg image/gif image/png]
    errors.add(:done_image1, :done_image1_type) unless allowed_file_types.include?(done_image1.blob.content_type)
  end
end
