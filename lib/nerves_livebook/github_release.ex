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

  @default_repository "fhunleth/nerves_livebook"
  @app "nerves_livebook"

  @base_url "https://api.github.com"

  use Tesla

  @type t() :: map()

  @doc """
  Request the latest release information from GitHub
  """
  @spec get_latest(String.t()) :: {:ok, t()} | {:error, atom()}
  def get_latest(repository \\ @default_repository) do
    client()
    |> get("/repos/#{repository}/releases/latest")
  end

  @doc """
  Return the release version as a string
  """
  @spec version(t()) :: String.t() | :error
  def version(release) do
    case release.body["tag_name"] do
      # Release version tags have a 'v', so if this doesn't follow the convention then
      # something is wrong.
      "v" <> version -> version
      _ -> :error
    end
  end

  @doc """
  Helper function for getting the firmware filename
  """
  @spec firmware_filename(String.t()) :: String.t()
  def firmware_filename(target) do
    @app <> "_" <> target <> ".fw"
  end

  @doc """
  Return the URL for downloading the firmware for a target

  If the target firmware isn't available, it returns an error
  """
  @spec firmware_url(t(), String.t()) :: {:ok, String.t()} | {:error, :not_found}
  def firmware_url(release, target) do
    filename = firmware_filename(target)

    case Enum.find(release.body["assets"], fn m -> m["name"] == filename end) do
      %{"browser_download_url" => url} -> {:ok, url}
      _ -> {:error, :not_found}
    end
  end

  @doc """
  Download a URL to the specified location
  """
  @spec download(String.t(), Path.t()) :: :ok | {:error, any()}
  def download(url, path) do
    middleware = [
      {Tesla.Middleware.FollowRedirects, max_redirects: 5},
      {Tesla.Middleware.Headers, [{"user-agent", user_agent()}]}
    ]

    result =
      middleware
      |> Tesla.client()
      |> Tesla.get(url)

    with {:ok, %{status: 200, body: body}} <- result,
         :ok <- File.write(path, body) do
      :ok
    end
  end

  def client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"user-agent", user_agent()}]}
    ]

    Tesla.client(middleware)
  end

  defp user_agent() do
    "NervesLivebook/#{NervesLivebook.version()}"
  end
end
