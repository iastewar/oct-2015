array = Array.new

print "Enter word for divisible by 3:"
word_1 = gets.chomp
word_1 = "FIZZ" if word_1 == ""

print "Enter word for divisible by 5:"
word_2 = gets.chomp
word_2 = "BUZZ" if word_2 == ""

for i in 1...100
  result = ""
  if i % 3 == 0
    result << word_1
  end
  if i % 5 == 0
    result << word_2
  end

  if result == ""
    array.push(i)
  else
    array.push(result)
  end
end

print array
