class Location < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :mayor, class_name: 'User', foreign_key: 'mayor_id'
  has_many :games
end
