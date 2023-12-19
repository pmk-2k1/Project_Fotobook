class LikePost < ApplicationRecord
  belongs_to :user
  belongs_to :interact, polymorphic: true

  #validations
  validates :interact_type, presence: true
  validates :interact_id, presence: true
end
