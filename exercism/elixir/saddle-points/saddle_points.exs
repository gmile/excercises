defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn(e) -> String.split(e, " ") |> Enum.map(&String.to_integer(&1)) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do

  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    a = rows(str)

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
      c = Enum.filter(b, fn {{r, _}, _} -> r == row end) # get row by index
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
  end
end
