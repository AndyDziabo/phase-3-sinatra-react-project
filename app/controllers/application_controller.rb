class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
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

  post '/add_favorite' do
    # binding.pry
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
      Team.create(user_id: params[:user_id] ,player_id: params[:player_id])
      fav = Player.find(params[:player_id])
      fav.is_drafted = true
      fav.save
    end

    fav.to_json
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
