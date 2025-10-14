defmodule Triangle do
  defguard is_triangle(a, b, c) when
    a > 0 and b > 0 and c > 0 and
    a + b >= c and a + c >= b and b + c >= a

  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    case {a, b, c} do
      {a, b, c} when not is_triangle(a, b, c) ->
        {:error, "All the values must be positive and the sum of any two sides must be greater than the third"}

      {a, b, c} when a == b and b == c ->
        {:ok, :equilateral}

      {a, b, c} when a == b or b == c or a == c ->
        {:ok, :isosceles}

      _ ->
        {:ok, :scalene}
    end
  end
end
