defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    {a1 * b2 + a2 * b1, b1 * b2}
    |> reduce
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    {a1 * b2 - a2 * b1, b1 * b2}
    |> reduce
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    {a1 * a2, b1 * b2}
    |> reduce
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    {a1 * b2, b1 * a2}
    |> reduce
  end

  @doc """
  Absolute value of a rational number
  """
  @spec rational_abs(a :: rational) :: rational
  def rational_abs({a1, b1}) do
    {Kernel.abs(a1), Kernel.abs(b1)}
    |> reduce
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1, b1}, n) when n >= 0 do
    {Integer.pow(a1, n), Integer.pow(b1, n)}
    |> reduce
  end

  def pow_rational({a1, b1}, n) when n < 0 do
    {Integer.pow(b1, abs(n)), Integer.pow(a1, abs(n))}
    |> reduce
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real({a1, b1}, n) do
    {Float.pow(a1, n), Float.pow(b1, n)}
    |> reduce
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce(a) do
    {a1, b1} = a
    gcd = Integer.gcd(a1, b1)
    {a1 / gcd, b1 / gcd}
  end
end
