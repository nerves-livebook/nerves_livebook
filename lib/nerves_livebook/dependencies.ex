defmodule NervesLivebook.Dependencies do
  @moduledoc false

  # List of apps that are provided by default by Erlang and Elixir
  @extra_applications [
    :asn1,
    :compiler,
    :crypto,
    :debugger,
    :eex,
    :elixir,
    :ex_unit,
    :ftp,
    :hex,
    :inets,
    :iex,
    :kernel,
    :logger,
    :mnesia,
    :mix,
    :nerves_livebook,
    :observer,
    :odbc,
    :os_mon,
    :parsetools,
    :public_key,
    :runtime_tools,
    :sasl,
    :snmp,
    :ssh,
    :ssl,
    :stdlib,
    :syntax_tools,
    :tftp,
    :tools,
    :wx,
    :xmerl
  ]

  @doc """
  Return included packages that can be used in Nerves Livebook
  """
  @spec packages() :: [Livebook.Runtime.package()]
  def packages() do
    for {app, description, version} <- Application.loaded_applications(),
        app not in @extra_applications do
      %{
        dependency: {app, "~> #{version}"},
        description: to_string(description),
        name: to_string(app),
        url: "https://hex.pm/packages/#{app}",
        version: to_string(version)
      }
    end
    |> Enum.sort()
  end
end
