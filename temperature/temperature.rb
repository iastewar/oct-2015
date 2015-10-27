require 'sinatra'
require 'sinatra/reloader'

enable :sessions

get "/" do
  erb(:temperature, {layout: :app_layout})
end

post "/" do
  @temp_c = params["temperature_c"].to_f
  @temp_f = @temp_c * 1.8 + 32
  session[:last_temp] = @temp_c
  erb(:temperature, {layout: :app_layout})
end

get "/background" do
  erb(:background, {layout: :app_layout})
end

post "/background" do
  session[:last_background] = params["background"]
  erb(:background, {layout: :app_layout})
end
