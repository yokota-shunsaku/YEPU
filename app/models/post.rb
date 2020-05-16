class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user, optional: true
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :genre, presence: true
  def self.search(search)   
        if search  
          where(['content LIKE ?', "%#{search}%"])   
        else  
          all  
        end  
  end
end
