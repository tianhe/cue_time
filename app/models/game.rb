class Game < ActiveRecord::Base
  validates :organizer_id, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :min_attendance, presence: true
  validates :max_attendance, presence: true  
  validates :location_id, presence: true

  belongs_to :organizer, class_name: 'User'
  has_many :players, through: :attendances, class_name: 'User'
  has_many :attendances
end
