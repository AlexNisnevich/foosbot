
@GameView =
  initialize: ->
    @enable_sorting()
    @enable_events()

  enable_sorting: ->
    $("#player-box").sortable({
      change: -> GameController.reposition GameView.get_arrangement()
    })
    $("#player-box").disableSelection()

  enable_events: ->
    $(".player").click(-> GameController.score GameView.get_name_from_elt(@) )
    $("#undo").click(-> GameController.undo_score() )
    $("#submit-game").click(-> GameController.send_results() )

  get_arrangement: ->
    players = $('.player .name').map((i, elt) -> elt.innerText)
    [[players[1], players[0]], [players[2], players[3]]] # as per schema.bnf

  get_name_from_elt: (elt) ->
    $(elt).find('.name').text()

  set_scores: (scores, totalScores) ->
    $(".black .score .value").text scores[0]
    $(".yellow .score .value").text scores[1]
    $(".black .total .value").text totalScores[0]
    $(".yellow .total .value").text totalScores[1]

  set_game_num: (num) ->
    $("#game .value").text num

@GameController =
  server_url: ""
  score_limit: 5

  match: []
  current_game: {}
  total_scores: [ 0, 0 ]

  initialize: (opts) ->
    @new_game GameView.get_arrangement()
    @server_url = opts.server_url

  new_game: (players) ->
    @current_game =
      goals: []
      arrangement: players
      scores: [ 0, 0 ]

    GameView.set_game_num( @match.length + 1 )

  score: (player) ->
    goal =
      time: new Date()
      scorer: player
      arrangement: @current_game.arrangement

    @current_game.goals.push goal

    scoring_team = (if player in @current_game.arrangement[0] then 0 else 1)
    @current_game.scores[scoring_team]++
    @total_scores[scoring_team]++

    if @current_game.scores[0] is @score_limit or @current_game.scores[1] is @score_limit
      @match.push @current_game
      @new_game @current_game.arrangement

    @refresh_scores()

  undo_score: ->
    if goal = @current_game.goals.pop()
      scoring_team = (if goal.scorer in @current_game.arrangement[0] then 0 else 1)
      @current_game.scores[scoring_team]--
      @total_scores[scoring_team]--

      # TODO: be able to undo a game-ending goal too

      @refresh_scores()

  refresh_scores: ->
    GameView.set_scores @current_game.scores, @total_scores

  reposition: (new_arrangement) ->
    @current_game.arrangement = new_arrangement

  send_results: ->
    $.post @server_url, @match
