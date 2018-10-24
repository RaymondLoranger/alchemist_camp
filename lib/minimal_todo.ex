defmodule MinimalTodo do
  alias __MODULE__.Spec
  alias IO.ANSI.Table

  @spec start() :: :ok
  def start do
    map_filename()
    |> parse_csv()
    |> csv_to_maps()
    |> map_sort_specs()
    |> format_maps()
  end

  ## Private functions

  @spec map_filename() :: Spec.t()
  defp map_filename do
    "Name of .csv to format: " |> IO.gets() |> String.trim() |> Spec.new()
  end

  @spec parse_csv(Spec.t()) :: Spec.t()
  defp parse_csv(%Spec{} = spec) do
    [headers | lines] =
      for line <- File.stream!(spec.filename) do
        line |> String.split(",") |> Enum.map(&String.trim/1)
      end

    %Spec{spec | headers: headers, lines: lines}
  end

  @spec map_sort_specs(Spec.t()) :: Spec.t()
  defp map_sort_specs(%Spec{} = spec) do
    %Spec{spec | sort_specs: Enum.slice(spec.headers, 0..1)}
  end

  @spec csv_to_maps(Spec.t()) :: Spec.t()
  defp csv_to_maps(%Spec{} = spec) do
    maps =
      Enum.map(spec.lines, fn line ->
        Enum.zip(spec.headers, line) |> Map.new()
      end)

    %Spec{spec | maps: maps}
  end

  @spec format_maps(Spec.t()) :: :ok
  defp format_maps(%Spec{} = spec) do
    Table.format(
      spec.maps,
      headers: spec.headers,
      sort_specs: spec.sort_specs,
      style: spec.style,
      bell: spec.bell
    )
  end
end
