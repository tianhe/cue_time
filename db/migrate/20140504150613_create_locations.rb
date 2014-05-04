class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :mayor_id
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.timestamps
    end
  end
end
