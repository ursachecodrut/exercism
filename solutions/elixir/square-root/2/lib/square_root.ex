defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(0), do: 0
  def calculate(1), do: 1
  def calculate(n) when n < 0, do: raise(ArgumentError, "radicand must be positive")
  def calculate(n), do: binary_search(n, 1, n)
    
  defp binary_search(left, right, target) do
    mid = div(left + right, 2)
    mid_squared = mid * mid
    cond do
      abs(mid_squared - target) <= 1 -> mid
      mid_squared < target -> binary_search(mid + 1, right, target)
      mid_squared > target -> binary_search(left, mid - 1, target)
    end
  end
end
