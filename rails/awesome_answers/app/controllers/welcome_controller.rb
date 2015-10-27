class WelcomeController < ApplicationController
  def index

  end

  def greeting
    @name = params[:name]
  end

  # /hello or /hello.html rails will render hello.html.erb
  # /hello.text rails will render hello.text.erb
  def hello        #hello.html.erb  (action name, response format, templating language (slim, haml, erb))
    #render({text: "Hello World"})
    #render(:hello, {layout: "application"}) #implied
  end

end
