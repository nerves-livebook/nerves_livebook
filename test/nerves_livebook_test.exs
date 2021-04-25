defmodule NervesLivebookTest do
  use ExUnit.Case

  test "check_internet!/0 doesn't raise on host" do
    NervesLivebook.check_internet!()
  end

  test "version/0" do
    # Just check that it's a parsable version since
    # there's no second source of truth to my knowledge.
    Version.parse!(NervesLivebook.version())
  end
end
