class Activity < ActiveRecord::Base
  validates :name, presence: true  

  has_many :games
  has_many :users, through: :user_activities
end
