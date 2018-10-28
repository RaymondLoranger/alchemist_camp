defmodule Fib.Timer do
  alias Fib.{Cache, Naive, Quick}

  @spec compare(non_neg_integer) :: :ok
  def compare(n \\ 40) when is_integer(n) and n >= 0 do
    using_time_utc_now(n)
    using_timer_tc(n)
  end

  ## Private functions

  @spec using_time_utc_now(non_neg_integer) :: :ok
  defp using_time_utc_now(n) do
    Cache.start_link()
    IO.puts("Using Time.utc_now/0:")

    if n <= 45 do
      {runtime, result} = time(&Naive.fib/1, n)
      IO.puts("Fib.Naive.fib(#{n}) = #{result} => #{runtime / 1_000_000} s")
    end

    {runtime, result} = time(&Quick.fib/1, n)
    IO.puts("Fib.Quick.fib(#{n}) = #{result} => #{runtime / 1_000_000} s")
    {runtime, result} = time(&Cache.fib/1, n)
    IO.puts("Fib.Cache.fib(#{n}) = #{result} => #{runtime / 1_000_000} s")
    Cache.stop()
  end

  @spec using_timer_tc(non_neg_integer) :: :ok
  defp using_timer_tc(n) do
    Cache.start_link()
    IO.puts("Using :timer.tc/3")

    if n <= 45 do
      {runtime, result} = :timer.tc(Naive, :fib, [n])
      IO.puts("Fib.Naive.fib(#{n}) = #{result} => #{runtime / 1_000_000} s")
    end

    {runtime, result} = :timer.tc(Quick, :fib, [n])
    IO.puts("Fib.Quick.fib(#{n}) = #{result} => #{runtime / 1_000_000} s")
    {runtime, result} = :timer.tc(Cache, :fib, [n])
    IO.puts("Fib.Cache.fib(#{n}) = #{result} => #{runtime / 1_000_000} s")
    Cache.stop()
  end

  @spec time((non_neg_integer -> non_neg_integer), non_neg_integer) ::
          {non_neg_integer, non_neg_integer}
  defp time(fun, n) when is_function(fun, 1) do
    t0 = Time.utc_now()
    result = fun.(n)
    t = Time.utc_now()
    {Time.diff(t, t0, :microsecond), result}
  end
end
