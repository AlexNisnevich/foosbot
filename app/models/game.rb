class Game < ActiveRecord::Base
  has_many :teams, :limit => 2
  has_many :rounds, :limit => 4

  RATING_COEFFICIENT = 50
  RATING_INTERVAL_WEIGHT_FACTOR = 1000

  after_create :initialize_teams

  def black_team
    teams.where(black_team: true).first
  end

  def yellow_team
    teams.where(black_team: false).first
  end

  def winner
    (black_team_score > yellow_team_score) ? black_team : yellow_team
  end

  def loser
    (black_team_score < yellow_team_score) ? black_team : yellow_team
  end

  def initialize_teams
    teams.create(black_team: true)
    teams.create(black_team: false)
  end

  # black_players and yellow_players are arrays
  def self.record(black_players, yellow_players, black_team_score, yellow_team_score)
    game = self.create(black_team_score: black_team_score, yellow_team_score: yellow_team_score)
    game.black_team.add_players(black_players)
    game.yellow_team.add_players(yellow_players)
    game.process_result
  end

  # black_players and yellow_players are hashes, rounds is an array of hashes
  def self.record_with_rounds(black_players, yellow_players, rounds, opts = {})

  end

  protected

  def process_result
    elo_adjustment = calculate_elo_adjustment(winner.elo, loser.elo)

    teams.each do |team|
      team.players.each do |player|
        player.games_played += 1

        if team == winner
          player.wins += 1
          player.elo += elo_adjustment
        else
          player.losses += 1
          player.elo -= elo_adjustment
        end

        player.save
      end
    end
  end

  def calculate_elo_adjustment (winner_elo, loser_elo)
    difference = winner_elo - loser_elo
    expected_result = 1 / (10 ** (- difference / RATING_INTERVAL_WEIGHT_FACTOR) + 1)

    RATING_COEFFICIENT * expected_result
  end
end
