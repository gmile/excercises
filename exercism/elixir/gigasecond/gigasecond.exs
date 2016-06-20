defmodule Gigasecond do
	@doc """
	Calculate a date one billion seconds after an input date.
	"""
	@spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

	def from(initial_date) do
    start = :calendar.datetime_to_gregorian_seconds(initial_date)
    :calendar.gregorian_seconds_to_datetime(1_000_000_000 + start)
	end
end
