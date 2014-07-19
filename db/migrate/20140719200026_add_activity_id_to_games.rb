class AddActivityIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :activity_id, :integer
  end
end
