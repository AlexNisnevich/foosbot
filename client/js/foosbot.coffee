
@GameView =
  initialize: ->
    $("#box").sortable({
      change: -> GameController.reposition( GameView.get_arrangement() )
    })
    $("#box").disableSelection()

  get_arrangement: ->
    players = $('.player .name').map((i, elt) -> elt.innerText)
    [[players[1], players[0]], [players[2], players[3]]] # as per schema.bnf

@GameController =
  server_url: ""
  score_limit: 5

  match: []
  current_game: {}

  new_game: (players) ->
    @current_game =
      goals: []
      arrangement: players
      scores: [ 0, 0 ]

  score: (player) ->
    goal =
      time: new Date()
      scorer: player
      arrangement: @current_game.arrangement

    @current_game.goals.push goal

    scoring_team = (if player in @current_game.arrangement[0] then 0 else 1)
    @current_game.scores[scoring_team]++

    if @current_game.scores[0] is @score_limit or @current_game.scores[1] is @score_limit
      @match.push @current_game
      @new_game @current_game.arrangement

  undo_score: ->
    @current_game.goals.pop

  reposition: (new_arrangement) ->
    @current_game.arrangement = new_arrangement

  send_results: ->
    $.post @server_url, @match
