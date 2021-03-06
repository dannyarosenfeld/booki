require 'stattleship'

class GameController < ApplicationController
  def index
    @games = Game.all
    @current_games = Game.current_games
    # @past_games = Game.past_games
    @teams = Team.all
  end

  def past
    @past_games = Game.all - Game.current_games
  end

  def show
     @game = Game.find(params[:id])
  end



  def create
    Stattleship.configure do |config|
      config.api_token = ENV['STATTLESHIP_API_KEY']
    end

    # dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
    # require File.join(dir, 'stattleship')
    require 'pp'

# Construct params for the fetch
query_params = Stattleship::Params::BaseballGamesParams.new

# use a slug, typically 'league-team_abbreviation'
# query_params.team_id = 'mlb-bos'

# may need to adjust this depending on time of year
query_params.season_id = 'mlb-2016'
query_params.status = 'upcoming'
query_params.on = 'today'

# fetch will automatically traverse the paginated response links
games = Stattleship::BaseballGames.fetch(params: query_params)

if games.length > 0
  # the populated object
  pp games.first

  # can access friendly helpers
  pp games.first.started_at.strftime('%b %e, %l:%M %p')

  # or, individual attributes
  games.each do |game|
    pp game.scoreline
  end
end

  p '*'*50
# Construct params for the fetch
query_params = Stattleship::Params::BaseballGamesParams.new

# use a slug, typically 'league-team_abbreviation'
# query_params.team_id = 'mlb-bos'

# may need to adjust this depending on time of year
query_params.season_id = 'mlb-2016'
# query_params.status = 'upcoming'
query_params.on = 'yesterday'

# fetch will automatically traverse the paginated response links
games = Stattleship::BaseballGames.fetch(params: query_params)

if games.length > 0
  # the populated object
  pp games.first

  # can access friendly helpers
  pp games.first.started_at.strftime('%b %e, %l:%M %p')

  # or, individual attributes
  games.each do |game|
    pp game.scoreline
  end
end

redirect_to root_path
end



end
