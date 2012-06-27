# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

players = [
  {name: 'Alex', gravatar_id: 'b60aa8e5bafe898f3390e505783d0c83'},
  {name: 'Ben', gravatar_id: '0f57518ebf1ccb746ac1b808444197da'},
  {name: 'Dmitri', gravatar_id: 'eb753b9773b6cccec999fa013335a5f3'},
  {name: 'Helen', gravatar_id: '443479a470dcb8fa7030005d7cdcfd28'},
  {name: 'Jarques', gravatar_id: '843c04e26dcc2d66376132185af790c2'},
  {name: 'Jure', gravatar_id: '8318c45b3f67537fdf3c5775d98de5e1'},
  {name: 'Richard', gravatar_id: '4b849a08c53453856bcb1671e1a1dfa4'},
  {name: 'Ryan1', gravatar_id: '6a81a3f4bb41d0efe66fb2d16884efbb'},
  {name: 'Ryan2', gravatar_id: 'ab7e9b99372e6a833721735df9265400'},
  {name: 'Ryan3', gravatar_id: '4b849a08c53453856bcb1671e1a1dfa4'},
  {name: 'Wybo', gravatar_id: '7079f35a8d450bb4bd3a235fbe2b9e26'}
]

names = %w{Alex Ben Dmitri Helen Jarques Jure Richard Ryan1 Ryan2 Ryan3 Wybo}


players.each do |player|
  Player.create(
    name: player[:name],
    gravatar_id: player[:gravatar_id],
    elo: 750,
    games_played: 0,
    wins: 0,
    losses: 0
  )
end