defmodule NervesLivebook do
  @moduledoc """
  Nerves Livebook firmware
  """

  @doc """
  Return the mix target that was used to build this firmware

  This is useful for locating firmware updates and checking if you're
  running on non-Nerves device.
  """
  @spec target() :: atom()
  def target() do
    Application.get_env(:nerves_livebook, :target)
  end

  @doc """
  Return the Nerves Livebook version

  This returns the version as a string.
  """
  @spec version() :: String.t()
  def version() do
    Application.loaded_applications()
    |> (fn apps -> :lists.keyfind(:nerves_livebook, 1, apps) end).()
    |> elem(2)
    |> to_string()
  end

  @doc """
  Convenience method for checking internet-connectivity for a Livebook
  """
  @spec check_internet!() :: :ok
  def check_internet!() do
    unless target() == :host or VintageNet.get(["connection"]) == :internet,
      do: raise("Please check that at least one network interface can reach the internet")

    :ok
  end
end
