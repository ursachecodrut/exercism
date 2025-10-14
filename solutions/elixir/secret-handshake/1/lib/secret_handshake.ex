defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  def action(1, bits), do: ["wink" | bits]
  def action(2, bits), do: ["double blink" | bits]
  def action(4, bits), do: ["close your eyes" | bits]
  def action(8, bits), do: ["jump" | bits]
  def action(16, bits), do: Enum.reverse(bits)
  def action(_, bits), do: bits

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    [8, 4, 2, 1, 16]
    |> Enum.map(&Bitwise.band(&1, code))
    |> Enum.filter(fn x -> x != 0 end)
    |> Enum.reduce([], fn x, acc -> action(x, acc) end)
  end
end
