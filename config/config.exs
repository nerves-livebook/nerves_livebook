import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay",
  provisioning: "config/provisioning.conf"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1603310828"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Add mime type to upload notebooks with `Phoenix.LiveView.Upload`
config :mime, :types, %{
  "text/plain" => ["livemd"]
}

# Sets the default storage backend
config :livebook, :storage, Livebook.Storage.Ets

# Livebook's explore section is built at compile-time
config :livebook, :explore_notebooks, [
  %{
    # Required notebook path
    path: "#{File.cwd!()}/priv/welcome.livemd",
    # Optional notebook identifier for URLs, as in /explore/notebooks/{slug}
    # By default the slug is inferred from file name, so there is no need to set it
    slug: "nerves",
    # Optional list of images
    # image_paths: [
    #  # This image can be sourced as images/myimage.jpg in the notebook
    #  "/path/to/myimage.jpg"
    # ],
    # Optional details for the notebook card. If omitted, the notebook
    # is hidden in the UI, but still accessible under /explore/notebooks/{slug}
    details: %{
      cover_path: "#{File.cwd!()}/assets/nerves.png",
      description:
        "Get to know how Livebook works with Nerves and try out Nerves-specific examples."
    }
  }
]

# Enable the embedded runtime which isn't available by default
config :livebook, :runtime_modules, [Livebook.Runtime.Embedded, Livebook.Runtime.Attached]

# Forward the package search trough a custom handler to only show local ones.
config :livebook, Livebook.Runtime.Embedded,
  load_packages: {NervesLivebook.Dependencies, :packages, []}

# Allow Livebook to reboot the device
config :livebook, :shutdown_enabled, true

# Defaults for required configurations
config :livebook,
  app_service_name: nil,
  app_service_url: nil

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end
