require 'sinatra'
require 'sinatra/reloader'
require "faker"

enable :sessions

# get "/" do
#   "<h1>Hello World</h1>"
# end

get "/" do
  @name = "Ian"
  @catch_phrase = Faker::Company.catch_phrase
  erb(:index, {layout: :app_layout})
end

get "/hello" do
  erb(:hello, {layout: :app_layout})
end

get "/hi" do
  "Hi There!"
end

get "/contact" do
  erb(:contact, {layout: :app_layout})
end

post "/contact_submit" do
  @params = params
  erb(:contact_submit, {layout: :app_layout})
end
