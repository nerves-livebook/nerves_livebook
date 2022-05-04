defmodule NervesLivebook.Dependencies do
  @moduledoc false

  @doc """
  Return included packages that can be used in Nerves Livebook

  TODO: Compute this dynamically
  """
  @spec packages() :: [Livebook.Runtime.package()]
  def packages() do
    # Return dependencies in this format:
    [
      %{
        dependency: {:kino, "~> 0.6.1"},
        description: "Interactive widgets for Livebook",
        name: "kino",
        url: "https://hex.pm/packages/kino",
        version: "0.6.1"
      }
    ]
  end
end
