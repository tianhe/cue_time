class LocationVisit < ActiveRecord::Base
  validates :user_id, presence: true
  validates :location_id, presence: true
  validates :visit_time, presence: true

  belongs_to :user
  belongs_to :location 
end
