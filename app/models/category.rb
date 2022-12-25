class Category < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true, length: { in: 1..10 }

  belongs_to :user

  has_many :posts, dependent: :destroy
end
