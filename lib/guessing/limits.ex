defmodule Guessing.Limits do
  use PersistConfig

  @low_range Application.get_env(@app, :low_range)
  @high_range Application.get_env(@app, :high_range)

  @spec get_range(String.t()) :: Range.t()
  def get_range(name) do
    range =
      IO.gets("#{name}, guessing range, please? [low high] ")
      |> String.trim()

    range
    |> String.split()
    |> case do
      [low, high] ->
        with {low, ""} when low in @low_range <- Integer.parse(low),
             {high, ""} when high in @high_range <- Integer.parse(high),
             true <- low <= high,
             do: low..high,
             else: (_ -> prompt_range(name))

      _other ->
        prompt_range(name)
    end
  end

  ## Private functions

  @spec prompt_range(String.t()) :: Range.t()
  defp prompt_range(name) do
    {low_first..low_last, high_first..high_last} = {@low_range, @high_range}
    IO.puts("Lower limit must be between #{low_first} and #{low_last}.")
    IO.puts("Upper limit must be between #{high_first} and #{high_last}.")
    IO.puts("Lower limit must be <= upper limit.")
    IO.puts("#{name}, please enter valid guessing range...")
    get_range(name)
  end
end
