def most_recurring_letter(str)
  new_str = str.gsub(" ", "").downcase
  arr = new_str.split("")
  hash = Hash.new

  max = 0
  most_reccur_lett = ""
  arr.each { |char|
    char_sym = char.to_sym
    if hash[char_sym]
      hash[char_sym] += 1
    else
      hash[char_sym] = 1
    end

    if hash[char_sym] > max
      max = hash[char_sym]
      most_reccur_lett = char
    end
  }

  return most_reccur_lett
end

puts "Type a sentence: \n"
str = gets.chomp

puts "The most recurring letter is: #{most_recurring_letter(str)}"
