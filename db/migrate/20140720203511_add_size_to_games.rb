class AddSizeToGames < ActiveRecord::Migration
  def change
    add_column :games, :size, :integer
    remove_column :games, :min_attendance
    remove_column :games, :max_attendance
  end
end
