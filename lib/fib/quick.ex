defmodule Fib.Quick do
  @spec fib(non_neg_integer) :: non_neg_integer
  def fib(0), do: 0
  def fib(n) when is_integer(n) and n > 0, do: fib(n, 0, 1)

  ## Private functions

  @spec fib(non_neg_integer, non_neg_integer, pos_integer) :: pos_integer
  defp fib(1, _acc1, acc2), do: acc2
  defp fib(n, acc1, acc2), do: fib(n - 1, acc2, acc1 + acc2)
end
