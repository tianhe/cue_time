class Game < ActiveRecord::Base
  validates :organizer_id, presence: true
  validates :location_id, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :size, presence: true
  validates :activity_id, presence: true
  
  enum status: [:open, :confirmed, :in_progress, :canceled, :completed]
  enum competitiveness: [:playground, :jv, :varsity]
  enum experience_level: [:beginner, :intermediate, :advanced]

  belongs_to :location
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  belongs_to :activity
  
  has_many :players, through: :attendances, class_name: 'User'
  has_many :attendances, dependent: :destroy

  after_save :create_organizer_attendance

  def create_organizer_attendance
    Attendance.create(user_id: organizer_id, game_id: id, status: 'confirmed')
  end
end
