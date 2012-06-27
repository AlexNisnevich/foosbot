
server_url = ""
score_limit = 5

match = []
current_game = {}

new_game = (players) ->
  current_game =
    goals: []
    arrangement: players
    scores: [ 0, 0 ]

score = (player) ->
  goal =
    time: new Date()
    scorer: player
    arrangement: current_game.arrangement

  current_game.goals.push goal

  scoring_team = (if (current_game.arrangement[0].indexOf(player) > -1) then 0 else 1)
  current_game.scores[scoring_team]++

  if current_game.scores[0] is score_limit or current_game.scores[1] is score_limit
    match.push current_game
    new_game current_game.arrangement

reposition = (new_arrangement) ->
  current_game.arrangement = new_arrangement

send_results = ->
  $.post server_url, match
