class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.integer :activity_id
      t.integer :user_id
    end
  end
end
