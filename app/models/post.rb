class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  mount_uploader :image, ImageUploader

  enum status: { public: 0, private: 1 }, _prefix: true
end
