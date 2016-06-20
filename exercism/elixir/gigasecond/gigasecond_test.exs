if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("gigasecond.exs")
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule GigasecondTest do
  use ExUnit.Case

  # @tag :pending
  test "from 4/25/2011" do
    assert Gigasecond.from({{2011, 4, 25}, {0, 0, 0}}) == {{2043, 1, 1}, {1, 46, 40}}
  end

  test "from 6/13/1977" do
    assert Gigasecond.from({{1977, 6, 13}, {0, 0, 0}}) == {{2009, 2, 19}, {1, 46, 40}}
  end

  test "from 7/19/1959" do
    assert Gigasecond.from({{1959, 7, 19}, {0, 0, 0}}) == {{1991, 3, 27}, {1, 46, 40}}
  end

  test "yourself" do
    assert Gigasecond.from({{1988, 5, 23}, {0, 0, 0}}) == {{2020, 1, 30}, {1, 46, 40}}
  end
end
