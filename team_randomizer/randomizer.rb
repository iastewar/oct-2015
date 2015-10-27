require 'sinatra'
require 'sinatra/reloader'

enable :sessions

# get "/" do
#   erb(:temperature, {layout: :app_layout})
# end
#
# post "/" do
#   @temp_c = params["temperature_c"].to_f
#   @temp_f = @temp_c * 1.8 + 32
#   session[:last_temp] = @temp_c
#   erb(:temperature, {layout: :app_layout})
# end
#
# get "/background" do
#   erb(:background, {layout: :app_layout})
# end
#
# post "/background" do
#   session[:last_background] = params["background"]
#   erb(:background, {layout: :app_layout})
# end

get "/" do
  erb(:randomizer, {layout: :app_layout})
end

post "/" do
  session[:names] = params["names"]
  session[:num_teams] = params["num_teams"]
  if (params["names"] && params["num_teams"])
    name_array = params["names"].split(",")
    if (name_array.length < params["num_teams"].to_i)
      @team_error = true
      return erb(:randomizer, {layout: :app_layout})
    end
    if (params["num_teams"].to_i == 0)
      return erb(:randomizer, {layout: :app_layout})
    end
    team_size = name_array.length / params["num_teams"].to_i
    remainder = name_array.length % params["num_teams"].to_i
    name_array.shuffle!
    count = 0
    team_count = 0
    @teams = []
    team = []
    index = 0
    while index < name_array.length-remainder
      team[count] = name_array[index]
      count += 1
      if count >= team_size
        @teams[team_count] = team
        team = []
        count = 0
        team_count += 1
      end
      index += 1
    end
    #either we need to add to last team, or add new teams until we reach num teams
    if remainder != 0
      count = 0
      while index < name_array.length
        @teams[count].push(name_array[index])
        index += 1
        count += 1
      end
    end

  end

  erb(:randomizer, {layout: :app_layout})
end
