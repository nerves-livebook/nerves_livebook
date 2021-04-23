defmodule NervesLivebook.GithubRelease do
  @moduledoc """
  Check for firmware updates from the Github releases of
  the NervesLivebook repo.

  # Example

    # Check for latest release
    {:ok, %{status: 200, body: %{"assets" => assets}}} = NervesLivebook.GithubRelease.latest_release()

    # Get the download url for this device
    {:ok, url} = NervesLivebook.GithubRelease.get_asset_url(assets, NervesLivebook.Application.target())

    # Download the firmware
    {:ok, path} = NervesLivebook.GithubRelease.download_firmware(url)

    # Apply the firmware
    NervesLivebook.GithubRelease.apply_firmware_update(path)

  """

  @app "nerves_livebook"
  @username "fhunleth"
  @repo "nerves_livebook"
  @base_url "https://api.github.com"
  @download_dir "/tmp"

  use Tesla

  @doc "applies a fwupdate to the running system"
  def apply_firmware_update(path) do
    extra_args = ["-d", "/tmp/testfw.img"]

    System.cmd("fwup", ["-t", "complete", "-i", path, "-a" | extra_args],
      into: IO.stream(:stdio, :line)
    )
  end

  @doc """
  Downloads an asset to the temporary directory
  """
  def download_firmware(url) do
    middleware = [
      {Tesla.Middleware.FollowRedirects, max_redirects: 5},
      {Tesla.Middleware.Headers,
       [
         {"user-agent", "Nerves-Livebook-#{version()}"}
       ]}
    ]

    result =
      middleware
      |> Tesla.client()
      |> Tesla.get(url)

    with {:ok, %{status: 200, headers: headers, body: body}} <- result,
         {:ok, filename} <- extract_filename(headers),
         :ok <- File.write(Path.join(@download_dir, filename), body) do
      {:ok, Path.join(@download_dir, filename)}
    end
  end

  @doc "looks for the content-disposition header and extracts the filename from it"
  @spec extract_filename([{String.t(), String.t()}]) :: {:ok, Path.t()} | nil
  def extract_filename([{"content-disposition", cd} | _]) do
    case Regex.named_captures(~r/filename=(?<filename>.+)/, cd) do
      %{"filename" => filename} -> {:ok, filename}
      _ -> nil
    end
  end

  def extract_filename([_ | rest]) do
    extract_filename(rest)
  end

  def extract_filename([]), do: nil

  @doc "Returns the latest release json for the repo"
  @spec latest_release :: {:ok, %{body: map()}} | any()
  def latest_release do
    client()
    |> get("/repos/#{@username}/#{@repo}/releases/latest")
  end

  @doc """
  Checks the release assets for a valid firmware url
  """
  @spec get_asset_url([map()], String.t()) :: {:ok, String.t()} | nil
  def get_asset_url([%{"browser_download_url" => url} | rest], target) do
    # "https://github.com/fhunleth/nerves_livebook/releases/download/v0.1.0/nerves_livebook_rpi0.fw"
    path = Path.split(URI.parse(url).path)
    ["/", @username, @repo, "releases", "download", _version, fw] = path
    @app <> "_" <> asset_target = Path.rootname(fw)

    case asset_target do
      ^target -> {:ok, url}
      _ -> get_asset_url(rest, target)
    end
  end

  def get_asset_url([], _target), do: nil

  def client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers,
       [
         {"user-agent", "Nerves-Livebook-#{version()}"}
       ]}
    ]

    Tesla.client(middleware)
  end

  defp version do
    Application.loaded_applications()
    |> (fn apps -> :lists.keyfind(:nerves_livebook, 1, apps) end).()
    |> elem(2)
    |> to_string()
    |> Version.parse!()
  end
end
