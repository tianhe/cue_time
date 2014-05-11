json.(@game, :id, :organizer_id, :location_id, :min_attendance, :max_attendance, :experience_level, :min_age, :max_age, :gender_requirement, :drinks_requirement, :competitiveness, :status)
json.start_time(@game.start_time.strftime("%Y-%m-%d %H:%M:%S %Z"))
json.end_time(@game.start_time.strftime("%Y-%m-%d %H:%M:%S %Z"))
