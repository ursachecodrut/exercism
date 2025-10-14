defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """

  @spec is_prime?(pos_integer()) :: boolean()
  def is_prime?(1), do: false

  def is_prime?(number) do
    2..trunc(:math.sqrt(number))//1
    |> Enum.to_list()
    |> Enum.filter(fn x -> rem(number, x) == 0 end) == []
  end

  def gen_prime_numbers(limit) do
    2..limit//1
    |> Enum.to_list()
    |> Enum.filter(fn x -> is_prime?(x) end)
  end

  def factors_for(number) do
    gen_prime_numbers(number)
    |> Enum.filter(fn x ->
      rem(number, x) == 0
    end)
  end
end
