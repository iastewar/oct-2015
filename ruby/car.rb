class Car
  $my_variable = "Hello"
  @@color = "Blue"
  MAX_SPEED = 200

  attr_reader :color
  attr_accessor :model, :type, :capacity

  def initialize(model, type, capacity)
    @model = model
    @type = type
    @capacity = capacity
    puts "Created car"
  end

  def self.max_speed #static
    MAX_SPEED
  end

  def drive
    ignite_engine
    puts "Driving..."
  end

  def park
    puts "Parking..."
  end

  def stop
    puts "Stopping..."
  end

  private

  def pump_gas
    puts "Pumping gas..."
  end

  def ignite_engine
    puts "Igniting engine..."
  end
end
