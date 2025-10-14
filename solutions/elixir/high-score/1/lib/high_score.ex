defmodule HighScore do
  def new() do
    %{}
  end

  def add_player(scores, name, score \\ 0) do
    scores = Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    scores = Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    scores = Map.put(scores, name, 0)
  end

  def update_score(scores, name, score) do
    scores = Map.update(scores, name, score, &(score + &1))
  end

  def get_players(scores) do
    scores
    |> Map.keys()
  end
end
