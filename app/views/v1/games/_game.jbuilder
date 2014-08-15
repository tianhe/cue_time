json.(game, :id, :title, :size, :experience_level, :min_age, :max_age, :gender_requirement, :drinks_requirement, :competitiveness, :status)
json.neighborhood(game.location.neighborhood)
json.organizer_name(game.organizer.name)
json.activity_name(game.activity.name)
json.start_time(game.start_time.strftime("%Y-%m-%d %H:%M:%S %Z"))
json.end_time(game.start_time.strftime("%Y-%m-%d %H:%M:%S %Z"))

json.attendances game.attendances do |attendance| 
  json.(attendance, :id, :game_id, :user_id, :status)
end
