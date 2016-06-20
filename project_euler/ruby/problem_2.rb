a     = [1, 2]
s     = a[-1] + a[-2]
flag  = 0
totag = 0

while s < 4_000_000
  a << s = a[-1] + a[-2]

  if flag.zero?
    flag  = 1
  else
    total += s
    flag  = 0
  end
end

puts total
