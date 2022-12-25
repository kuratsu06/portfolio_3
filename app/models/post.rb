class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true, length: { in: 1..10 }
  validates :memo, length: { in: 1..50 }
  validates :status, presence: true
  
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
