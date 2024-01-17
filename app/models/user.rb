class User < ApplicationRecord
  enum gender: {other: 0 , male: 1, female: 2}
  has_secure_password

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_name, presence: true, length: { minimum: 3 }

  def own?(object)
    object.user_id == id
  end
end
