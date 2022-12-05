# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[line] # for LINE LOGIN

  has_many :varieties, dependent: :nullify
  has_many :schedules, dependent: :destroy
  has_many :tasks, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  after_create :initialize_notification_time

  def social_profile(provider)
    social_profiles.find(provider: provider.to_s)
  end

  def auth_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
  end

  def auth_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    save!
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def initialize_notification_time
    update!(notification_time: '08:00:00')
  end
end
