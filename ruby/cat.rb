require './bird.rb'

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def catch(bird)
    r = rand
    if r > 0.5
      puts "#{name} Caught bird #{bird.name}!"
      bird.alive = false
    else
      puts "#{name} Didn't catch bird #{bird.name}!"
    end
  end

end
