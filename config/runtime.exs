import Config

mix_target = Nerves.Runtime.mix_target()
{:ok, hostname} = :inet.gethostname()

# Start with Livebook defaults
Livebook.config_runtime()

# Store notebooks in a writable location on the device
notebook_path =
  if mix_target == :host do
    Path.expand("priv") <> "/"
  else
    "/data/livebook/"
  end

config :livebook,
  home: notebook_path,
  file_systems: [Livebook.FileSystem.Local.new(default_path: notebook_path)]

# Use the embedded runtime to run notebooks in the same VM
config :livebook,
  default_runtime: Livebook.Runtime.Embedded.new(),
  default_app_runtime: Livebook.Runtime.Embedded.new()

# Configure plugs
config :livebook,
  plugs: [{NervesLivebook.RedirectNervesLocal, []}]

# Modify to update the password on device
# config :livebook,
#   authentication: {:password, "nerves"}

# Set the Erlang distribution cookie
config :livebook,
  node: :"livebook@#{hostname}.local",
  cookie: :nerves_livebook_cookie

# Endpoint configuration
port = if mix_target == :host, do: 8080, else: 80

config :livebook, LivebookWeb.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  url: [host: "#{hostname}.local", path: "/"],
  pubsub_server: Livebook.PubSub,
  live_view: [signing_salt: "livebook"],
  drainer: [shutdown: 1000],
  render_errors: [formats: [html: LivebookWeb.ErrorHTML], layout: false],
  http: [
    port: port,
    http_1_options: [max_header_length: 32768]
  ],
  code_reloader: false,
  server: true

config :livebook, :iframe_port, 8081

# Blink the LED to show that we're booting
config :delux, initial: Delux.Effects.blink(:cyan, 2)
