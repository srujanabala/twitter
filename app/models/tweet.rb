class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  validates :content, length: {maximum: 140}, presence: true
  validates :user, presence: true 
end
