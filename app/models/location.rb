class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :mayor_id, presence: true
  validates :address, presence: true

  belongs_to :user, foreign_key: 'mayor_id'
end
