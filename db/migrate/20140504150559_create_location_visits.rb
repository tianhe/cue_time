class CreateLocationVisits < ActiveRecord::Migration
  def change
    create_table :location_visits do |t|
      t.integer :user_id
      t.integer :location_id
      t.datetime :visit_time

      t.timestamps
    end
  end
end
