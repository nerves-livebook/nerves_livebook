defmodule NervesLivebook.MixInstallTest do
  use ExUnit.Case
  alias NervesLivebook.MixInstall

  test "already installed dependencies" do
    assert :ok == MixInstall.install([:kino, {:vega_lite, "~> 0.1.0"}], [])
  end

  test "raises on uninstalled dependency" do
    assert_raise RuntimeError, fn ->
      MixInstall.install([:not_a_real_package], [])
    end
  end

  test "raises on dependency with unsupported requirement" do
    assert_raise RuntimeError, fn ->
      MixInstall.install([{:kino, "~> 1000.0.0"}], [])
    end
  end
end
