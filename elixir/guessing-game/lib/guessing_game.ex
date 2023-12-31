defmodule GuessingGame do
  def compare(secret_number, :no_guess), do: "Make a guess"

  def compare(secret_number, guess) when secret_number === guess, do: "Correct"

  def compare(secret_number, guess) when guess in [secret_number - 1, secret_number + 1],
    do: "So close"

  def compare(secret_number, guess) when secret_number < guess, do: "Too high"
  def compare(secret_number, guess) when secret_number > guess, do: "Too low"

  def compare(secret_number, guess \\ :no_guess), do: "Make a guess"
end
