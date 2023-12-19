class Photo < ApplicationRecord
  # users
  belongs_to :user

  # album
  belongs_to :album, optional: true

  # like_posts
  has_many :like_posts, as: :interact

  # attr_accessible :album_id, :name, :image
  mount_uploader :image, ImageUploader

  # validates
  validates :title, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :is_private, inclusion: [true, false]
  scope :is_public, -> { where(is_private: false)}
end
