require 'sinatra'
require 'sinatra/reloader'

enable :sessions

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
    if (params["num_teams"].to_i <= 0)
      @zero_error = true
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
    # need to add the remainder
    count = 0
    while index < name_array.length
      @teams[count].push(name_array[index])
      index += 1
      count += 1
    end
  end

  erb(:randomizer, {layout: :app_layout})
end
