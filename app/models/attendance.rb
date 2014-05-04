class Attendance < ActiveRecord::Base
  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :status, presence: true

  belongs_to :user
  belongs_to :game
end
