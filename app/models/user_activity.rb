class UserActivity < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: { scope: :activity_id }
  validates :activity_id, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :activity
end
