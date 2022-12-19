class Complete < ApplicationRecord
  belongs_to :user
  belongs_to :post

  mount_uploader :image, ImageUploader

  enum again: { enough: 0, again: 1 }
  enum status: { public: 0, private: 1 }, _prefix: true
end
