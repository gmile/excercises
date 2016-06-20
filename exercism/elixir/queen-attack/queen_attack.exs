defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(a \\ {0, 3}, b \\ {7, 3})
  def new({x,y}, {x,y}), do: raise ArgumentError
  def new(a, b), do: %Queens{ white: a, black: b }

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do

  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{ white: {a,b}, black: {y,x} }) when y == a + b - x, do: true
  def can_attack?(%{ white: {a,b}, black: {y,x} }) when y == x + a - b, do: true
  def can_attack?(%{ white: {a,_}, black: {a,_} }), do: true
  def can_attack?(%{ white: {_,b}, black: {_,b} }), do: true
  def can_attack?(_), do: false
end
