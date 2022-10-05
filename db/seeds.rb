puts "Deleting tables..."
Player.delete_all
Player.reset_pk_sequence
Favorite.delete_all
Favorite.reset_pk_sequence
Team.delete_all
Team.reset_pk_sequence

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

puts "Done seeding!"
