class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, uniqueness: true
  validates_presence_of :password, :password_confirmation

  validates_presence_of :api_key, uniqueness: true

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end