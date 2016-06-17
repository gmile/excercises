defmodule Meetup do
  @days %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

  @schedule %{
    first:  1,
    second: 1 + 7,
    third:  1 + 7 * 2,
    fourth: 1 + 7 * 3,
    last:   1 + 7 * 4,
    teenth: 13
  }
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    a = starting_day(year, month, schedule)
    b = @days[weekday]

    day = day_of_month(a, b, schedule)
    day = if day > 31, do: day - 7, else: day
    day = if day >= 31 && month == 2, do: day - 7 - 1, else: day

    {year, month, day}
  end

  defp day_of_month(a, b, s) when b >= a, do: @schedule[s] + b - a
  defp day_of_month(a, b, s) when b  < a, do: @schedule[s] + b - a + 7

  defp starting_day(year, 2, :last) do
    :calendar.day_of_the_week(year, 2, 28)
  end

  defp starting_day(year, month, schedule) do
    :calendar.day_of_the_week(year, month, @schedule[schedule])
  end
end
