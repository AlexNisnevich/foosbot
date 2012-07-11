
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

  match: []
  current_game: null
  total_scores: [ 0, 0 ]

  match_ended: false
  tournament_style: false
  num_repositions: 0

  initialize: (opts) ->
    @new_game GameView.get_arrangement()
    @server_url = opts.server_url

  new_game: (players) ->
    @current_game = new Game(players)
    @match.push @current_game
    @refresh_scores()

  score: (player) ->
    @current_game.add_goal player

    if @current_game.is_game_over()
      @new_game @current_game.arrangement

      if @is_match_over()
        @send_results()

    @refresh_scores()

  undo_score: ->
    if @current_game.is_empty() and @match.length > 1
      @match.pop()
      @current_game = @match[@match.length - 1]

    @current_game.undo_goal()
    @refresh_scores()

  refresh_scores: ->
    add_arrays = (prevVal, val) -> [prevVal[0] + val[0], prevVal[1] + val[1]]
    scores = @match.map (game) -> game.scores
    @total_scores = scores.reduce add_arrays, [0, 0]

    GameView.set_scores @current_game.scores, @total_scores
    GameView.set_game_num @match.length

  reposition: (new_arrangement) ->
    @current_game.reposition new_arrangement
    @num_repositions++
    if @num_repositions >= 4
      # minimum of 4 repositions in tournament style game
      @tournament_style = true

  is_match_over: ->
    if @tournament_style
      @match.length >= 3
    else
      @match.length >= 4

  send_results: ->
    $.post @server_url, @match
    @match_ended = true

class Game
  score_limit: 5

  constructor: (arrangement) ->
    @goals = []
    @arrangement = arrangement
    @scores = [ 0, 0 ]

  get_team_from_player: (player) ->
    if player in @arrangement[0]
      0
    else
      1

  is_empty: ->
    @scores[0] == 0 and @scores[1] == 0

  is_game_over: ->
    @scores[0] >= @score_limit or @scores[1] >= @score_limit

  add_goal: (player) ->
    goal =
      time: new Date()
      scorer: player
      arrangement: @arrangement

    @goals.push goal
    @scores[@get_team_from_player player]++

  undo_goal: ->
    if goal = @goals.pop()
      @scores[@get_team_from_player goal.scorer]--

  reposition: (@arrangement) ->
