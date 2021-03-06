class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :password, presence: true

  has_many :user_activities
  has_many :activities, through: :user_activities

  has_many :organized_games, class_name: 'Game', foreign_key: 'organizer_id'

  has_many :attendances
  has_many :attending_games, through: :attendances, source: :game

  has_many  :authentications
  accepts_nested_attributes_for :authentications

  has_one  :player_profile
  has_many :location_visits
  has_many :mayorships, class_name: 'Location', foreign_key: 'mayor_id'

  before_save :ensure_authentication_token
  before_validation :ensure_password
  
  enum gender: [:male, :female]
  enum drinking_habit: [:dry, :light, :social, :pro, :alcoholic]

private
  def ensure_password
    self.password ||= Devise.friendly_token.first(8)
  end

  def ensure_authentication_token
    self.authentication_token ||= Devise.friendly_token
  end
end
