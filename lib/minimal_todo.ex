defmodule MinimalTodo do
  alias IO.ANSI.Table

  def start do
    "Name of .csv to load: "
    |> IO.gets()
    |> String.trim()
    |> parse_and_format()
  end

  def parse_and_format(filename) do
    [headers | lines] =
      for line <- File.stream!(filename) do
        line |> String.split(",") |> Enum.map(&String.trim/1)
      end

    Enum.map(lines, fn line ->
      Enum.zip(headers, line) |> Map.new()
    end)
    |> Table.format(
      headers: headers,
      sort_specs: Enum.slice(headers, 0..1),
      style: :light,
      bell: true
    )
  end
end
