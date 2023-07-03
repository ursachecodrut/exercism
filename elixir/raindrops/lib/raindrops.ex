defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """

  @raindrops %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    factors =
      [3, 5, 7]
      |> Enum.filter(fn factor -> rem(number, factor) == 0 end)

    if length(factors) == 0 do
      to_string(number)
    else
      factors
      |> Enum.map(fn factor -> @raindrops[factor] end)
      |> Enum.join()
    end
  end
end
