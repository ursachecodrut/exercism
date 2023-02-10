defmodule GuessingGame do
  def compare(number, guess \\ :no_guess)
  def compare(number, number), do: "Correct"
  def compare(_, :no_guess), do: "Make a guess"
  def compare(number, guess) when abs(number - guess) === 1, do: "So close"
  def compare(number, guess) when guess > number, do: "Too high"
  def compare(number, guess) when guess < number, do: "Too low"
end
