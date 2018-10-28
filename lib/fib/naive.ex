defmodule Fib.Naive do
  @spec fib(non_neg_integer) :: non_neg_integer
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when is_integer(n) and n > 1, do: fib(n - 1) + fib(n - 2)
end
