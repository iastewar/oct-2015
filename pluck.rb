def pluck(arr, prop_name)
  arr.map { |obj|
    obj[prop_name.to_sym]
  }
end

puts pluck([{a:1}, {a:2}], 'a')
