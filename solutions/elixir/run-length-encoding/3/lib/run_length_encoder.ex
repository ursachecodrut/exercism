defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    graphemes = String.graphemes(string)
    build_encoded_string(graphemes, 1, "")
  end

  def build_encoded_string([], count, acc), do: acc <> integer_to_counter(count)

  def build_encoded_string([c1 | []], count, acc), do: acc <> integer_to_counter(count) <> c1

  def build_encoded_string([c1 | [c2 | tail]], count, acc) when c1 == c2 do
    build_encoded_string([c2 | tail], count + 1, acc)
  end

  def build_encoded_string([c1 | [c2 | tail]], count, acc) when c1 != c2 do
    build_encoded_string([c2 | tail], 1, acc <> integer_to_counter(count) <> c1)
  end

  def integer_to_counter(1), do: ""
  def integer_to_counter(num), do: Integer.to_string(num)

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r{(\d*)(.)}, string)
    |> Enum.map(&expand/1)
    |> Enum.join()
  end

  def expand([_, "", letter]), do: letter
  def expand([_, count, letter]), do: String.duplicate(letter, String.to_integer(count))
end
