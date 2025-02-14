defmodule DocTestesTest do
  use ExUnit.Case
  doctest DocTestes

  test "greets the world" do
    assert DocTestes.hello() == :world
  end
end
