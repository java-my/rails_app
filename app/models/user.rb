class User < ApplicationRecord
  enum gender: {other: 0 , male: 1, female: 2}
  has_secure_password

  has_many :articles, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_name, presence: true, length: { minimum: 3 }
end
