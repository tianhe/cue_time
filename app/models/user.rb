class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :name, presence: true

  has_many :organized_games, class_name: 'Game', foreign_key: 'organizer_id'
  has_many :attendances
  has_many :attending_games, class_name: 'Game', through: :attendance

  has_one :player_profile
  has_many :location_visits
  has_many :mayorships, class_name: 'Location', foreign_key: 'mayor_id'

end
