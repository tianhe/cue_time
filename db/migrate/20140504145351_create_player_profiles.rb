class CreatePlayerProfiles < ActiveRecord::Migration
  def change
    create_table :player_profiles do |t|
      t.string :experience
      t.integer :ranking, default: 1000
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.references :user
      
      t.timestamps
    end
  end
end
