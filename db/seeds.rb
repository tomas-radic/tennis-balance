# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating users..."
binding.pry
User.destroy_all
binding.pry
me = User.create(
  email: 'tomas.radic@gmail.com',
  password: 'tenniswherever',
  password_confirmation: 'tenniswherever'
)

puts "Creating players..."
Player.destroy_all
me_player = me.players.create(name: 'Tomáš Radič')
turky = me.players.create(name: 'Peťo Turček')

puts "Creating matches, tournaments, seasons..."
Match.destroy_all
Tournament.destroy_all
Season.destroy_all
winter_2017_2018 = Season.create(name: 'Zima 2017-2018')
set1 = GameSet.create(games: [7, 5], sequence_nr: 1)
set2 = GameSet.create(games: [3, 6], sequence_nr: 2)
set3 = GameSet.create(games: [1, 0], tiebreak: [7, 4], sequence_nr: 3)

match = me.matches.build(
  date_played: '2018-01-15',
  place: 'Dudova, Bratislava',
  season: winter_2017_2018
)

match.game_sets << set1 << set2 << set3
match.player_participants << me_player << turky
binding.pry
match.save

puts "Finished."
