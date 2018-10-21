defmodule Guessing.Game do
  alias Guessing.{Limits, Player}

  @spec play :: true
  def play, do: play(Player.get_name())

  ## Private functions

  @spec play(String.t()) :: true
  defp play(name), do: play(name, Limits.get_range(name))

  @spec play(String.t(), Range.t()) :: true
  defp play(name, range) do
    "#{name}, I'm guessing #{mid(range)}? [Yhl] "
    |> IO.gets()
    |> String.trim()
    |> String.downcase()
    |> String.first()
    |> case do
      "h" ->
        higher(name, range)

      "l" ->
        lower(name, range)

      reply when reply in ["y", nil] ->
        if play_again?(name) do
          play(name)
        else
          self() |> Process.exit(:normal)
        end

      _other ->
        IO.puts(~s{Type "y" (yes), "h" (higher) or "l" (lower)...})
        play(name, range)
    end
  end

  @spec mid(Range.t()) :: integer()
  defp mid(%Range{first: low, last: high} = _range), do: div(low + high, 2)

  @spec higher(String.t(), Range.t()) :: true
  defp higher(name, %Range{first: low, last: high} = _range) do
    new_low = min(high, mid((low + 1)..high))
    play(name, new_low..high)
  end

  @spec lower(String.t(), Range.t()) :: true
  defp lower(name, %Range{first: low, last: high} = _range) do
    new_high = max(low, mid(low..(high - 1)))
    play(name, low..new_high)
  end

  @spec play_again?(String.t()) :: boolean
  defp play_again?(name) do
    IO.puts("I knew I'd guess your number!")

    "#{name}, play again? [Yn] "
    |> IO.gets()
    |> String.trim()
    |> String.downcase()
    |> String.first()
    |> case do
      reply when reply in ["y", nil] -> true
      _other -> false
    end
  end
end
