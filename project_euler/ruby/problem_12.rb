require 'prime'

current = i = 1

class Integer
  def muls
    out = [1]

    (2..self/2).each do |i|
      out << i if self.modulo(i).zero?
    end

    out << self
  end
end

30.times do |i|
  muls = (i+1).muls
  puts "#{i+1}: #{muls.inspect}"
end

# until (x = current.amount_of_multipliers) >= 500
#   current += (i += 1)
#   puts "#{current}: #{x}"
# end
