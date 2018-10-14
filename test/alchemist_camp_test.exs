defmodule AlchemistCampTest do
  use ExUnit.Case
  doctest AlchemistCamp

  test "greets the world" do
    assert AlchemistCamp.hello() == :world
  end
end
