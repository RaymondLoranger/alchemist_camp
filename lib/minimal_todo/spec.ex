defmodule MinimalTodo.Spec do
  @moduledoc false

  alias __MODULE__

  @enforce_keys [:filename]
  defstruct filename: "",
            maps: [],
            headers: [],
            lines: [],
            sort_specs: [],
            style: :light,
            bell: true

  @type t :: %Spec{
          filename: String.t(),
          maps: [map],
          headers: [String.t()],
          lines: [list],
          sort_specs: [String.t()],
          style: atom,
          bell: boolean
        }

  @spec new(String.t()) :: t()
  def new(filename) do
    %Spec{filename: filename}
  end
end
