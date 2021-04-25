defmodule NervesLivebookTest do
  use ExUnit.Case

  test "check_internet!/0 doesn't raise on host" do
    NervesLivebook.check_internet!()
  end
end
