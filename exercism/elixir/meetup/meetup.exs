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
    a = :calendar.day_of_the_week(year, month, @schedule[schedule])
    b = @days[weekday]
    day = @schedule[schedule] + days(a, b, schedule)

    {year, month, day}
  end

  defp days(a, b, :last), do: b - a
  defp days(a, b, _) when b >= a, do: b - a
  defp days(a, b, _) when b  < a, do: b - a + 7
end
