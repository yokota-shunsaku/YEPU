class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user, optional: true
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  validates :content, presence: true, length: { maximum: 255 }
  
end
