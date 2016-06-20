require 'set'
require 'ostruct'

candidates = [[3,4,5]]

def result array
  array[0] + array[1] + array[2] == 1000
end

cycle = 0
=begin
for a in 1..500
  x = a
  y = 1000 -a

  b = (y**2 - x**2) / 2*y
  c = (y**2 + x**2) / 2*y

  puts b
end
=end
34.times do
#until result(candidates.last)
  a, b, c = candidates[-1-cycle]
  candidates << case cycle
  when 0
    cycle += 1
    [a - 2*b + 2*c, 2*a - b + 2*c, 2*a - 2*b + 3*c]
  when 1
    cycle += 1
    [a + 2*b + 2*c, 2*a + b + 2*c, 2*a + 2*b + 3*c]
  when 2
    cycle = 0
    [-a + 2*b + 2*c, -2*a + b + 2*c, -2*a + 2*b + 3*c]
  end

  puts candidates.last.inspect + "#{candidates.last[0] + candidates.last[1] + candidates.last[2]}"
end
