require 'digest/sha1'

#finds original password given that it is 5 letters, lower case, and uses SHA1 hashing
def find_password(hashed_password)
  password = %w(a a a a a)
  _find_password(hashed_password, password, 0)
  return password.join
end

def _find_password(hashed_password, password, index)
  if index >= password.length
    return false
  end

  for char in "a".."z"
      password[index] = char
      hash = Digest::SHA1.hexdigest(password.join)
      if (hash == hashed_password)
        return true
      end
      res = _find_password(hashed_password, password, index+1)
      if res
        return true
      end
  end

  return false
end


puts find_password("aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d")
