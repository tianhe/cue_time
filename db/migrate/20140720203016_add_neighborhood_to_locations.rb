class AddNeighborhoodToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :neighborhood, :string
  end
end
