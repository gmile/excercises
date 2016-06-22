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

# Filter row
c   = Enum.filter(b, fn {{_,r},_} -> r == row end)
{{_, _,}, max} = Enum.max_by(c, fn {_,v} -> v end )
all_max = Enum.filter(c, fn {_,v} -> v == max end)

IO.inspect(all_max)
point = { {max_x, max_y} = {2, 0}, max_val = 5}

# saddle_points_0 = Enum.filter(all_max, fn {coords1, v1} ->

  b = Enum.filter(b, fn {{x, y}, _} -> { x, y } != {max_x, max_y} && x == max_x end)
  c = Enum.all?(b, fn {_, v2} -> max_val <= v2 end)
# end)

IO.puts("B: ")
IO.inspect(b)
IO.puts("C: ")
IO.inspect(c)

IO.inspect(max)
IO.inspect(all_max)
# IO.inspect(saddle_points_0)
