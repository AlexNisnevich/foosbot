class Player < ActiveRecord::Base
  has_many :teams
  has_many :games, :through => :teams

  def profile_photo(size = 80)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def self.get(player)
    if player.is_a? Player
      return player
    elsif player.is_a? String
      return Player.find_by_name(player)
    elsif player.is_a? Integer
      return Player.get(player)
    else
      raise "Invalid argument to Player.get: #{player}"
    end
  end
end
