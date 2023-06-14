defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    resolve_path(data, keys)
  end

  defp resolve_path(nil, _), do: nil
  defp resolve_path(data, []), do: data
  defp resolve_path(data, [key | keys]), do: resolve_path(data[key], keys)

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
