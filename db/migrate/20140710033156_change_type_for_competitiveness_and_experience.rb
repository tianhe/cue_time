class ChangeTypeForCompetitivenessAndExperience < ActiveRecord::Migration
  def change
    change_column :games, :competitiveness, 'integer USING CAST(competitiveness AS integer)'
    change_column :games, :experience_level, 'integer USING CAST(experience_level AS integer)'
  end
end
