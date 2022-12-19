class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader

  has_many :categories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :completes, dependent: :destroy
  has_many :likes, dependent: :destroy
end
