class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get '/users' do
    users = User.all
    users.to_json
  end

  get '/user_count' do
    count = User.all.count
    count.to_json
  end

  get "/players" do
    player = Player.all
    player.to_json
  end

  get '/player/:id' do
    player = Player.find(params[:id])
    player.to_json
  end

  get "/favorites/:id" do
    user = User.find(params[:id])
    favorites = user.favorites
    favorites.to_json
  end

  get '/teams/:id' do
    teams = Team.where(user_id: params[:id])
    teams.to_json
  end

  get '/teams/player_name/:player_id' do
    player = Player.find(params[:player_id])
    player.to_json
  end 

  get '/teams/starting_lineup/:id' do
    team = Team.where({user_id: params[:id], starter: true})
    team.to_json
  end

  get '/teams/benched/:id' do
    team = Team.where({user_id: params[:id], starter: false})
    team.to_json
  end

  get '/starter_count/:id' do
    count = Team.where({user_id: params[:id], starter: true}).count
    count.to_json
  end

  get "/team_name" do
    team = Player.pluck(:team_name).uniq
    team.to_json
  end

  get "/positions" do
    position = Player.pluck(:position).uniq
    position.to_json
  end

  get '/draft_team_select/:team/:position' do
    if params[:team] != 'all' && params[:position] != 'all'
      select = Player.where({team_name: params[:team], position: params[:position]})
    elsif params[:team] != 'all'
      select = Player.where(team_name: params[:team])
    elsif params[:position] != 'all'
      select = Player.where(position: params[:position])
    else
      select = Player.all      
    end
    select.to_json
  end

  get '/team_count/:user_id' do
    count = Team.where(user_id: params[:user_id]).count
    count.to_json
  end

  get '/position_count/:user_id/:position' do
    user = User.find(params[:user_id])
    count = user.players.where({is_drafted: true, position: params[:position]}).count
    count.to_json
  end

  get '/team/:user_id' do
    list = Team.where(user_id: params[:user_id])
    ids = list.pluck(:player_id)
    team = Player.find(ids)
    team.to_json
  end

  get '/draft_pos_info/:user_id' do
    user = User.find(params[:user_id])
    flex = user.favorites.where(flex: true)
    defense = user.favorites.where(defense: true)
    info = flex + defense
    info.to_json
  end

  post '/add_user' do
      user = User.create(name: params[:name], team_name: params[:team_name])
    user.to_json
  end

  post '/add_team' do
      team = Team.create(name: params[:name], user_id: params[:user_id])
    team.to_json
  end

  post '/add_favorite' do
    if Favorite.where({user_id: params[:user_id], player_id: params[:player_id]}).present?
      fav = "duplicate"
    else
      fav = Favorite.create(user_id: params[:user_id] ,player_id: params[:player_id], flex: params[:flex], defense: params[:defense], position: params[:position])
    end

    fav.to_json
  end

  post '/draft_player' do
    if Team.where({user_id: params[:user_id], player_id: params[:player_id]}).present?
      fav = "duplicate"
    else
      Team.create(name: params[:name], user_id: params[:user_id] ,player_id: params[:player_id], starter: false, position: params[:position], flex: false, defense: params[:defense])
      fav = Player.find(params[:player_id])
    end
    fav.to_json
  end

  patch '/is_drafted/:id' do
    player = Player.find(params[:id])
    player.update(is_drafted: params[:is_drafted])
    player.to_json
  end

  patch '/teams/:id' do
    team = Team.find(params[:id])
    team.update(starter: params[:starter], flex: params[:flex])
    team.to_json
  end

  delete '/fav_delete/:user/:player' do
    fav = Favorite.find_by({user_id: params[:user], player_id: params[:player]})
    fav.delete
    fav.to_json
  end

  get '/test/:user_id/:player_id' do
    binding.pry
  end

  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

end
