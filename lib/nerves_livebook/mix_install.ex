defmodule NervesLivebook.MixInstall do
  @moduledoc """
  Simulate Mix.install for Nerves Livebook

  Nerves Livebook currently doesn't support `Mix.install/1`, but hopefully it
  will in the future. As a workaround, check whether dependencies that the user
  specifies are available and give them a help message if not.
  """

  @spec install([atom() | {atom(), keyword()} | {atom(), binary(), keyword()}], keyword()) :: :ok
  def install(deps, opts) when is_list(deps) and is_list(opts) do
    deps
    |> Enum.map(&normalize/1)
    |> Enum.each(&check_dep/1)
  end

  defp normalize(app) when is_atom(app), do: {app, ">= 0.0.0"}

  defp normalize({app, opts}) when is_atom(app) and is_list(opts) do
    check_for_path_dep(app, opts)
    {app, ">= 0.0.0"}
  end

  defp normalize({app, requirement}) when is_atom(app) and is_binary(requirement) do
    {app, requirement}
  end

  defp normalize({app, requirement, opts})
       when is_atom(app) and is_binary(requirement) and is_list(opts) do
    check_for_path_dep(app, opts)
    {app, requirement}
  end

  defp normalize(other) do
    raise RuntimeError, """
    Don't know how to install #{inspect(other)}.
    """
  end

  defp check_for_path_dep(app, opts) do
    if Keyword.has_key?(opts, :path) do
      raise RuntimeError, """
      Path dependency for #{inspect(app)} is not supported in Nerves Livebook.
      """
    end
  end

  defp check_dep({app, requirement}) do
    case Application.spec(app, :vsn) do
      nil ->
        raise RuntimeError, """
        Mix.install is not supported on Nerves Livebook (yet!).

        All is not lost, but you will have to rebuild the Nerves Livebook firmware.
        Go to https://github.com/livebook-dev/nerves_livebook and clone the repository.
        Add #{inspect(app)} to the dependencies listed in the `mix.exs` file, build,
        and then try again.
        """

      vsn ->
        Version.match?(to_string(vsn), requirement) ||
          raise RuntimeError, """
          The dependency #{inspect(app)} is installed in Nerves Livebook but it
          doesn't match the version requirement #{inspect(requirement)}.

          Here are ways to fix this:

          1. Change the version requirement to {#{inspect(app)}, "~> #{vsn}"}
          2. Rebuild the Nerves Livebook firmware and update the version in
             its mix.exs.

          If Nerves Livebook includes an old version, please file a PR so that
          we can update it.
          """
    end
  end
end
