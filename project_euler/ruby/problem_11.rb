@array = Array.new

File.foreach("problem_11_input.txt") do |line|
  @array << line.scan(/\d+/).map { |item| item.to_i }
end

def max_col_product x, y
  @array[x..x+3].inject(1) { |m, a| m*a[y] }
end

def max_row_product x, y
  @array[x][y..y+3].inject(:*)
end

def max_diag_1_product x, y
  [ @array[x][y], @array[x+1][y-1], @array[x+2][y-2], @array[x+3][y-3] ].inject(:*)
end

def max_diag_2_product x, y
  [ @array[x][y], @array[x+1][y+1], @array[x+2][y+2], @array[x+3][y+3] ].inject(:*)
end

i_max = j_max = @array.size-4
max = 0

@array.each_index do |i|
  @array[i].each_index do |j|
    row = col = diag_1 = diag_2 = 0

    row    = max_row_product(i, j)    if j <= j_max
    col    = max_col_product(i, j)    if i <= i_max
    diag_1 = max_diag_1_product(i, j) if i <= i_max && j <= j_max && i > 2 && j > 2
    diag_2 = max_diag_2_product(i, j) if i <= i_max && j <= j_max

    max = [max, row, col, diag_1, diag_2].max
  end
end

puts max
