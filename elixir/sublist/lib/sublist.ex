defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist?(a, b) -> :superlist
      sublist?(b, a) -> :sublist
      true -> :unequal
    end
  end

  def sublist?([], _), do: false
  def sublist?(l1 = [_ | t], l2) do
    List.starts_with?(l1, l2) or sublist?(t, l2)
  end
end
