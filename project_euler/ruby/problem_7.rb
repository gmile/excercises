primes  = [2]
barrier = 2
i       = 0

until primes.size == 10001
  i += 1
  candidate = primes.last + i

  unless primes.select { |p| p <= barrier }.any? { |x| candidate % x == 0 }
    primes << candidate
    barrier = (primes.last**(0.5)).ceil
    i       = 0
  end
end

puts primes.last(10)
