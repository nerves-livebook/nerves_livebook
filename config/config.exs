import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay",
  provisioning: "config/provisioning.conf"

if Mix.env() != :test do
  # Set log level to warning by default to reduce output except for testing
  # The unit tests rely on info level log messages.
  config :logger, level: :warning
end

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1603310828"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Additional mime types
config :mime, :types, %{
  "audio/m4a" => ["m4a"],
  "text/plain" => ["livemd"]
}

# Sets the default storage backend
config :livebook, :storage, Livebook.Storage.Ets

# Livebook's learn section is built at compile-time
config :livebook, :learn_notebooks, [
  %{
    # Required notebook path
    path: "#{File.cwd!()}/priv/welcome.livemd",
    # Optional notebook identifier for URLs, as in /learn/notebooks/{slug}
    # By default the slug is inferred from file name, so there is no need to set it
    slug: "nerves",
    # Optional list of images
    # image_paths: [
    #  # This image can be sourced as images/myimage.jpg in the notebook
    #  "/path/to/myimage.jpg"
    # ],
    # Optional details for the notebook card. If omitted, the notebook
    # is hidden in the UI, but still accessible under /learn/notebooks/{slug}
    details: %{
      cover_path: "#{File.cwd!()}/assets/nerves.svg",
      description: "Get to know how Livebook works with Nerves."
    }
  },
  %{
    path: "#{File.cwd!()}/priv/samples/networking/configure_wifi.livemd",
    slug: "wifi",
    details: %{
      cover_path: "#{File.cwd!()}/assets/wifi-setup.svg",
      description: "Connect Nerves Livebook to a wireless network."
    }
  },
  %{path: "#{File.cwd!()}/priv/samples/basics/sys_class_leds.livemd", details: nil},
  %{path: "#{File.cwd!()}/priv/samples/networking/firmware_update.livemd", details: nil},
  %{path: "#{File.cwd!()}/priv/samples/networking/vintage_net.livemd", details: nil}
]

# Enable the embedded runtime which isn't available by default
config :livebook, :runtime_modules, [Livebook.Runtime.Embedded, Livebook.Runtime.Attached]

# Forward the package search trough a custom handler to only show local ones.
config :livebook, Livebook.Runtime.Embedded,
  load_packages: {NervesLivebook.Dependencies, :packages, []}

# Allow Livebook to power off  the device
config :livebook, :shutdown_callback, {Process, :spawn, [Nerves.Runtime, :poweroff, [], []]}

# Defaults for required configurations
config :livebook,
  agent_name: "default",
  allowed_uri_schemes: [],
  app_service_name: nil,
  app_service_url: nil,
  authentication: {:password, "nerves"},
  aws_credentials: false,
  feature_flags: [],
  force_ssl_host: nil,
  plugs: [],
  rewrite_on: [],
  # Livebook 0.16: teams_auth: nil,
  teams_auth?: false,
  teams_url: "https://teams.livebook.dev",
  github_release_info: %{
    repo: "nerves-livebook/nerves_livebook",
    version: Mix.Project.config()[:version]
  },
  update_instructions_url: nil,
  within_iframe: false

config :livebook, Livebook.Apps.Manager, retry_backoff_base_ms: 5_000
config :livebook, LivebookWeb.Endpoint, code_reloader: false

config :nerves_hub_link,
  connect: false,
  host: "https://your-nerves-hub-server.com",
  configurator: NervesHubLink.Configurator.SharedSecret

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end
