def array_to_hash(arr)
  hash = Hash.new
  arr.each { |x|
    if (x.is_a? Numeric)
      hash[x] = x**2
    elsif (x.is_a? String)
      hash[x] = x.length
    end
  }
  return hash
end

array = [1,2,23,4,"dfjkj","uugbunjj", 9]
puts array_to_hash(array)
