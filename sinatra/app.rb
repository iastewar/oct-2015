require 'sinatra'
require 'sinatra/reloader'

# get "/" do
#   "<h1>Hello World</h1>"
# end

get "/" do
  @name = "Ian"
  erb(:index)
end

get "/hello" do
  "Hey There!"
end

get "/hi" do
  "Hi There!"
end
