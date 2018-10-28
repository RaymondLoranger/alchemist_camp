defmodule Fib.Cache do
  alias __MODULE__

  @spec start_link :: Agent.on_start()
  def start_link do
    cache = %{0 => 0, 1 => 1}
    Agent.start_link(fn -> cache end, name: Cache)
  end

  @spec stop :: :ok
  def stop, do: Agent.stop(Cache)

  @spec fib(non_neg_integer) :: non_neg_integer
  def fib(n) when is_integer(n) and n >= 0 do
    Agent.get_and_update(Cache, &fib(&1, n), 15000)
  end

  ## Private functions

  @spec fib(map, non_neg_integer) :: {non_neg_integer, map}
  defp fib(cache, n) do
    if cached = cache[n] do
      {cached, cache}
    else
      {val, cache} = fib(cache, n - 1)
      result = val + cache[n - 2]
      {result, Map.put(cache, n, result)}
    end
  end
end
