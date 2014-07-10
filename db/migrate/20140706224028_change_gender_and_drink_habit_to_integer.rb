class ChangeGenderAndDrinkHabitToInteger < ActiveRecord::Migration
  def self.up
    change_column :users, :drinking_habit, 'integer USING CAST(drinking_habit AS integer)'
    change_column :users, :gender, 'integer USING CAST(gender AS integer)'
  end

  def self.down
    change_column :users, :drinking_habit, :string
    change_column :users, :gender, :string
  end
end
