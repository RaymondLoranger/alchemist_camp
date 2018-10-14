defmodule Guessing.Player do
  use PersistConfig

  @fave_name Application.get_env(@app, :fave_name)

  @spec get_name() :: String.t()
  def get_name() do
    name =
      IO.gets("Hi, your name, please? [name] ")
      |> String.trim()

    # Rough name validation...
    if String.match?(name, ~r/^[A-ZÉÈÑ][A-ZÉÑa-zéèñ -]*$/) do
      greeting(name)
    else
      IO.puts("Please enter a valid name...")
      get_name()
    end
  end

  ## Private functions

  @spec greeting(String.t()) :: String.t()
  defp greeting(name) do
    if name == @fave_name do
      IO.puts("Hi #{name} (it is my favorite name), nice to meet you!!")
    else
      IO.puts("Hi #{name}, nice to meet you!")
    end

    name
  end
end
