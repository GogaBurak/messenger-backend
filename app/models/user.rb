class User < ApplicationRecord
  has_secure_password

  validates :phone, presence: true, uniqueness: true
  validates :password, presence: true
end
