
var server_url = '';
var score_limit = 5;

var match = [];
var current_game;

function new_game(players) {
  current_game = {
    goals: [],
    arrangement: players,
    scores: [0, 0]
  }
}

function score(player) {
  var goal = {
    'time': new Date(),
    'scorer': player,
    'arrangement': current_game.arrangement
  }
  current_game.goals.push(goal);

  scoring_team = (current_game.arrangement[0].indexOf(player) != -1) ? 0 : 1;
  current_game.scores[scoring_team]++;

  if (current_game.scores[0] == score_limit || current_game.scores[1] == score_limit) {
    match.push(current_game);
    new_game();
  }
}

function reposition(new_arrangement) {
  current_game.arrangement = new_arrangement;
}

function send_results() {
  $.post(server_url, match);
}
