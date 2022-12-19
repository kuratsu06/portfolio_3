class Like < ApplicationRecord
  belongs_to :user
  belongs_to :complete

  validates_uniqueness_of :complete_id, scope: :user_id
end
