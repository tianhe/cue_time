json.(attendance, :id, :game_id, :user_id, :status)
json.game do
  json.partial! 'v1/games/game', game: attendance.game
end

