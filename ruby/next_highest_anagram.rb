class AnagramFinder
  def initialize(start_num)
    @start_num = start_num
  end

def next_highest
  start = @start_num
  hash = Hash.new
  arr = start.to_s.split("")
  for i in 0...arr.length
    elem = arr[i].to_sym
    if hash[elem] == nil
      hash[elem] = 1
    else
      hash[elem] += 1
    end
  end

  while true
    tmp_hash = hash.clone
    start += 1
    tmp_arr = start.to_s.split("")
    is_ann = true
    for i in 0...arr.length
      elem = tmp_arr[i].to_sym
      if tmp_hash[elem] == nil || tmp_hash[elem] == 0
        is_ann = false
        break
      else
        tmp_hash[elem] -= 1
      end
    end

    if is_ann
      return start
    end
  end
end

#   def next_highest
#       arr = @start_num.to_s.split("")
#
#       exists = false;
#       for i in 1...arr.length
#         if arr[i] > arr[i-1]
#           exists = true
#           break
#         end
#       end
#
#       if !exists
#         return @start_num
#       end
#
#       i = arr.length-2
#       while i >= 0
#         if arr[i] > arr[i+1]
#           tmp = arr[i]
#           arr[i] = arr[i+1]
#           arr[i+1] = tmp
#         else
#           tmp = arr[i]
#           arr[i] = arr[i+1]
#           arr[i+1] = tmp
#           break
#         end
#
#         i -= 1
#       end
#
#       return arr.join.to_i
#   end

end

puts AnagramFinder.new(9199910).next_highest
