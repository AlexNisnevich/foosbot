class Team < ActiveRecord::Base
  belongs_to :game
  belongs_to :first_player, :class_name => "Player"
  belongs_to :second_player, :class_name => "Player"

  def add_players(players)
    if players.is_a? Hash
      self.first_player = Player.get(players.first_player)
      self.second_player = Player.get(players.second_player)
    elsif players.is_a? Array
      self.first_player = Player.get(players[0])
      self.second_player = Player.get(players[1])
    end
    save
  end

  def players
    [first_player, second_player]
  end

  def elo
    (first_player.elo + second_player.elo) / 2
  end
end
