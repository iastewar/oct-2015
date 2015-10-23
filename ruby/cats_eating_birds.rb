require './cat.rb'

for i in 1..100
  c = Cat.new(i)
  b = Bird.new(i)
  c.catch(b)
end
