class Album < ApplicationRecord
  belongs_to :user

  has_many :photos, dependent: :destroy

  has_many :like_posts, as: :interact

  mount_uploaders :images, ImageUploader


  # validates
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :is_private, inclusion: [true, false]
end
