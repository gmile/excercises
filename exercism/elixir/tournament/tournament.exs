defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    custom_sort = fn
      {_, p1}, {_, p2} when p1 > p2 -> true
      {_, p1}, {_, p2} when p1 < p2 -> false
      {t1, p1}, {t2, p2} when p1 == p2 -> t1 <= t2
    end

    headers = {"Team", {"MP", "W", "D", "L", "P"}}
    totals =
      input
      |> Enum.reduce(%{}, fn line, totals ->
        line
        |> parse_game_info()
        |> record_result(totals)
      end)
      |> Enum.sort_by(fn {team, {_, _, _, _, points}} -> {team, points} end, custom_sort)

    render([headers | totals])
  end

  defp parse_game_info(line) do
    case String.split(line, ";") do
      [team1, team2, outcome] when outcome in ["win", "loss", "draw"] ->
        {team1, team2, outcome}
      _ ->
        {nil, nil, nil}
    end
  end

  defp record_result({team1, team2, "win"}, totals), do: do_record_result(totals, team1, team2, &win/1, &loss/1)
  defp record_result({team1, team2, "loss"}, totals), do: do_record_result(totals, team1, team2, &loss/1, &win/1)
  defp record_result({team1, team2, "draw"}, totals), do: do_record_result(totals, team1, team2, &draw/1, &draw/1)
  defp record_result({_, _, _}, total), do: total

  defp do_record_result(totals, team1, team2, team1_outcome, team2_outcome) do
    totals
    |> Map.put_new(team1, {0, 0, 0, 0, 0})
    |> Map.put_new(team2, {0, 0, 0, 0, 0})
    |> Map.update(team1, 0, team1_outcome)
    |> Map.update(team2, 0, team2_outcome)
  end

  defp win({mp, w, d, l, p}), do: {mp + 1, w + 1, d, l, p + 3}
  defp loss({mp, w, d, l, p}), do: {mp + 1, w, d, l + 1, p}
  defp draw({mp, w, d, l, p}), do: {mp + 1, w, d + 1, l, p + 1}

  defp render(rows) do
    Enum.map_join rows, "\n", fn {team, {mp, w, d, l, p}} ->
      Enum.join [String.pad_trailing(team, 30), col(mp), col(w), col(d), col(l), col(p)], " | "
    end
  end

  defp col(value) do
    value =
      cond do
        is_binary(value) ->
          value
        is_integer(value) ->
          Integer.to_string(value)
      end

    String.pad_leading(value, 2)
  end
end
