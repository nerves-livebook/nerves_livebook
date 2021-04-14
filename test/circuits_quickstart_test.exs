defmodule NervesLivebookTest do
  use ExUnit.Case
  doctest NervesLivebook

  test "greets the world" do
    assert NervesLivebook.hello() == :world
  end
end
