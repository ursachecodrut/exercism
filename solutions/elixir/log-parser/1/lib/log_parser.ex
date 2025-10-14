defmodule LogParser do
  def valid_line?(line) do
    String.match?(line, ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]\s/)
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line[0-9]+/i, "")
  end

  def tag_with_user_name(line) do
    match = Regex.run(~r/User\s+(\S+)/, line)
    case match do
      [_, user] -> "[USER] #{user} " <> line
      nil -> line
    end
  end
end
