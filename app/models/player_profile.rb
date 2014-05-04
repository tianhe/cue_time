class PlayerProfile < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  validates :ranking, presence: true
  validates :wins, presence: true
  validates :losses, presence: true  
end
