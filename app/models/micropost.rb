class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presense: true
  validates :content, presense: true, length: { maximum: 140 }
end
