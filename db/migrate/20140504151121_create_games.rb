class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :min_attendance
      t.integer :max_attendance
      t.integer :organizer_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :location_id
      t.integer :experience_level
      t.integer :max_age
      t.integer :min_age
      t.string :gender_requirement
      t.string :drinks_requirement
      t.string :competitiveness
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
