defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  def loop(balance \\ 0) do
    receive do
      {sender, :close} ->
        Process.exit(self(), :normal)
      {sender, :balance} ->
        send(sender, balance)
        loop(balance)
      {sender, {:deposit, amount}} ->
        cond do
          amount < 0 -> 
            send(sender, :amount_must_be_positive)
            loop(balance)
          true ->  
            send(sender, :ok)
            loop(balance + amount)
        end
      {sender, {:withdraw, amount}} ->
        cond do
          balance - amount >= 0 ->
            send(sender, :not_enough_balance)
            loop(balance)
          amount < 0 -> 
            send(sender, :amount_must_be_positive)
            loop(balance)
          true ->
            send(sender, :ok)
            loop(balance - amount)
        end
    end
  end

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    spawn(&loop/0)
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    send(account, {self(), :close})
    receive do
      _ -> :ok
    after
      100 -> {:error, :account_closed}
    end
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    send(account, {self(), :balance})
    receive do
      balance when is_integer(balance) -> balance
    after
      100 -> {:error, :account_closed}
    end
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
    send(account, {self(), {:deposit, amount}})
    receive do
      :ok -> :ok
      error -> error
    after
      100 -> {:error, :account_closed}
    end
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
    send(account, {self(), {:withdraw, amount}})
    receive do
      :ok -> :ok
      error -> error
    after
      100 -> {:error, :account_closed}
    end
  end
end
