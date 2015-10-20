def ascii_triangle(n)
  if (n < 1)
    return
  end
  arr = Array.new(2 * n - 1)

  for i in 0..arr.length-1
    arr[i] = " "
  end

  arr[n] = "O"

  begin_index = n-1
  end_index = n+1
  for i in 1..n

    for j in 0..arr.length-1
      print arr[j]
    end
    print "\n"

    for j in begin_index..end_index
      if arr[j] == "O"
        arr[j] = " "
      else
        arr[j] = "O"
      end
    end

    begin_index -= 1
    end_index += 1

  end

end

ascii_triangle(10)
