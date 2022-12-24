class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  mount_uploader :image, ImageUploader

  enum status: { public: 0, private: 1 }, _prefix: true

  has_many :completes, dependent: :destroy

  def self.search(search)
    if search
      Post.where(['title LIKE ? OR memo LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Post.all
    end
  end
end
