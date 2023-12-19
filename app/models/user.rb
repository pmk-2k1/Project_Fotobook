class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy

  #followuser
  has_many :follow_by_users, class_name: "FollowUser", foreign_key: "follower_id"
  has_many :followings, through: :follow_by_users
  has_many :following_users, class_name: "FollowUser", foreign_key: "following_id"
  has_many :followers, through: :following_users

  #like_post
  has_many :like_posts, dependent: :destroy
  
  #follow_user
  has_many :interact_album, through: :like_posts, source: :interact, source_type: "Album"
  has_many :interact_photo, through: :like_posts, source: :interact, source_type: "Photo"

  #add avatar
  mount_uploader :avatar, AvatarUploader

  #validate
  validates :first_name, :last_name, presence: true, length: {maximum: 25}
  validates :email, presence: true, uniqueness: true, length: {miximum:5, maximum: 255 },
  format: { with: /\A[\w+\_.]+@[a-z\d]+\.[a-z]+\z/i}
  validates :admin, inclusion: [true, false]

end
