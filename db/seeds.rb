puts "Deleting tables..."
Player.delete_all
Player.reset_pk_sequence
Favorite.delete_all
Favorite.reset_pk_sequence
Team.delete_all
Team.reset_pk_sequence
User.delete_all
User.reset_pk_sequence

puts "Seeding players..."

i=1
34.times do
    res = RestClient.get "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams/#{i}/roster"
    player_hash = JSON.parse(res)
    puts "Seeding #{player_hash["team"]["name"]} players..."
    player_hash["athletes"].each do |group|
        group["items"].each do |p|
            if p["status"]["name"] != "Practice Squad"
                Player.create(
                    name: p["fullName"],
                    position: p["position"]["name"],
                    number: p["jersey"],
                    status: p["status"]["name"],
                    is_drafted: false,
                    team_name: player_hash["team"]["name"],
                    team_location: player_hash["team"]["location"],
                    team_logo: player_hash["team"]["logo"],
                    image: p["headshot"],
                    catagory: group["position"]                
                )
            end
        end
    end
    i = i + 1
end

# puts "Seeding Favs..."

# Favorite.create(user_id: 1, player_id: 64, flex: 0, defense: 0, position: "Quarterback")
# Favorite.create(user_id: 1, player_id: 330, flex: 0, defense: 0, position: "Quarterback")
# Favorite.create(user_id: 2, player_id: 83, flex: 0, defense: 0, position: "Running Back")
# Favorite.create(user_id: 3, player_id: 193, flex: 0, defense: 0, position: "Running Back")
# Favorite.create(user_id: 3, player_id: 316, flex: 0, defense: 0, position: "Running Back")
# Favorite.create(user_id: 3, player_id: 2, flex: 0, defense: 0, position: "Wide Receiver")
# Favorite.create(user_id: 4, player_id: 25, flex: 0, defense: 0, position: "Wide Receiver")
# Favorite.create(user_id: 4, player_id: 79, flex: 0, defense: 0, position: "Wide Receiver")
# Favorite.create(user_id: 5, player_id: 7, flex: 0, defense: 0, position: "Tight End")
# Favorite.create(user_id: 6, player_id: 12, flex: 0, defense: 0, position: "Tight End")
# Favorite.create(user_id: 7, player_id: 78, flex: 0, defense: 0, position: "Tight End")
# Favorite.create(user_id: 8, player_id: 61, flex: 0, defense: 0, position: "Place kicker")
# Favorite.create(user_id: 9, player_id: 120, flex: 0, defense: 0, position: "Place kicker")
# Favorite.create(user_id: 7, player_id: 31, flex: 0, defense: 1, position: "Linebacker")
# Favorite.create(user_id: 7, player_id: 395, flex: 0, defense: 1, position: "Tight End")
# Favorite.create(user_id: 8, player_id: 750, flex: 1, defense: 0, position: "Running Back")
# Favorite.create(user_id: 6, player_id: 456, flex: 1, defense: 0, position: "Wide Receiver")
# Favorite.create(user_id: 1, player_id: 765, flex: 1, defense: 0, position: "Tight End")

# puts "Seeding Users..."

# User.create(name: "Miranda", team_name: "Bees Knees")
# User.create(name: "Tom", team_name: "Tom's Team")
# User.create(name: "Dave", team_name: "Crushers")
# User.create(name: "Amy", team_name: "Panthers")
# User.create(name: "Steve", team_name: "Lions")
# User.create(name: "Tim", team_name: "Tim's Team")
# User.create(name: "John", team_name: "Snakes")
# User.create(name: "Sam", team_name: "Team Awesome")
# User.create(name: "Brandon", team_name: "Bruisers")

# puts "Seeding Teams..."

# Team.create(name: "Bees Knees", user_id: 1, player_id: 18, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 19, starter: false)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 11, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 14, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 221, starter: false)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 16, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 29, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 23, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 28, starter: false)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 30, starter: true)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 33, starter: false)
# Team.create(name: "Bees Knees", user_id: 1, player_id: 37, starter: true)

puts "Done seeding!"