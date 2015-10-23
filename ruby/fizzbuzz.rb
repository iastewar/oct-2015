for i in 1..100
  result = ""
  if i % 3 == 0
    result << "FIZZ"
  end
  if i % 5 == 0
    result << "BUZZ"
  end

  if result == ""
    puts i
  else
    puts result
  end
end
