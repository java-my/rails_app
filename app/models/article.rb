class Article < ApplicationRecord
  paginates_per 20
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { minimum: 1, maximum: 20 }
  validates :body, length: { minimum: 0, maximum: 90 }
end
