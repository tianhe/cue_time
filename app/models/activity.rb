class Activity < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :games
  
  has_many :user_activities
  has_many :users, through: :user_activities
end
