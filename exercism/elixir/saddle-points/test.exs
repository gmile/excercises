a = [[3,4,5], [1,2,7],[4,5,6]]
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
    put_in(acc, [{i, j}], value)
  end)

IO.puts("B:")
IO.inspect(b)

row = 0

c   = Enum.filter(b, fn {{_, r}, _} -> r == row end) # get row by index
{{_, _,}, max} = Enum.max_by(c, fn {_, v} -> v end ) # find max in a row

c
|> Enum.filter(fn {_, v} -> v == max end)      # find all maxes in that row
|> Enum.filter(fn {{max_x, max_y}, max_val} -> # iterate over all maxes
     b
     |> Enum.filter(fn {{x, y}, _} -> {x, y} != {max_x, max_y} && x == max_x end) # find all points in that column (except current max)
     |> Enum.all?(fn {_, v2} -> max_val <= v2 end)                                # check if they are all "good"
   end)
|> Enum.map(fn {c, _} -> c end)
|> IO.inspect

# IO.puts("B: ")
# IO.inspect(b)
#
# IO.inspect(max)
# IO.inspect(saddle_points_0)
