class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :complete_id, presence: true
  validates :content, presence: true, length: { in: 1..50 }

  belongs_to :user
  belongs_to :complete
end
