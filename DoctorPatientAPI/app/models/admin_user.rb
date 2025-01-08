# app/models/admin_user.rb
class AdminUser < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = loop do
      key = SecureRandom.uuid
      break key unless AdminUser.exists?(api_key: key)
    end
  end
end