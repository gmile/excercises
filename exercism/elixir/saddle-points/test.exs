# a = [
#   [18, 3, 39, 19, 91],
#   [38, 10, 8, 77, 320],
#   [3, 4, 8, 6, 7]
# ]

a = [
  [4, 5, 4],
  [3, 5, 5],
  [1, 5, 4]
]

# a = [
#   [1, 2],
#   [3, 4]
# ]

b =
  a
  |> Enum.with_index
  |> Enum.map(fn {line, i} ->
    line
    |> Enum.with_index
    |> Enum.map(&Tuple.append(&1, i))
  end)
  |> List.flatten
  |> Enum.reduce(%{}, fn {value, i, j}, acc ->
    put_in(acc, [{j, i}], value)
  end)

for row <- 0..length(a)-1 do
  c   = Enum.filter(b, fn {{r, _}, _} -> r == row end) # get row by index
  {_, max} = Enum.max_by(c, fn {_, v} -> v end)        # find max in a row

  c
  |> Enum.filter(fn {_, v} -> v == max end)    # find all maxes in that row
  |> Enum.filter(fn {{max_y, max_x}, max_v} -> # iterate over all maxes
       b
       |> Enum.filter(fn {{y, x}, _} -> {y, x} != {max_y, max_x} && x == max_x end) # find all points in that column (except current max)
       |> Enum.all?(fn {_, v} -> max_v <= v end)                                # check if they are all "good"
     end)
  |> Enum.reduce([], fn {point, _}, acc -> [point | acc] end)
end
|> List.flatten
|> IO.inspect

# IO.puts("B: ")
# IO.inspect(b)
#
# IO.inspect(max)
# IO.inspect(saddle_points_0)
