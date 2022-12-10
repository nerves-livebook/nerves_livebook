import Config

mix_target = Nerves.Runtime.mix_target()

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
  default_runtime: Livebook.Runtime.Embedded.new()

# Configure plugs
config :livebook,
  plugs: [{NervesLivebook.RedirectNervesLocal, []}]

# Set the password to "nerves".
config :livebook,
  authentication_mode: :password,
  password: "nerves"

# Set the Erlang distribution cookie
config :livebook,
  cookie: :nerves_livebook_cookie

# Endpoint configuration
port = if mix_target == :host, do: 8080, else: 80

{:ok, hostname} = :inet.gethostname()

config :livebook, LivebookWeb.Endpoint,
  pubsub_server: Livebook.PubSub,
  live_view: [signing_salt: "livebook"],
  http: [
    port: port,
    transport_options: [socket_opts: [:inet6]]
  ],
  url: [host: "#{hostname}.local", path: "/"],
  code_reloader: false,
  server: true

config :livebook, :iframe_port, 8081

# Setup Erlang distribution
with {_, 0} <- System.cmd("epmd", ["-daemon"]),
     {:ok, _pid} <- Node.start(:"livebook@#{hostname}.local") do
  # Livebook always sets the cookie, so let it set it. See the Livebook application config.
  :ok
end

# Blink the LED to show that we're booting
config :delux, initial: Delux.Effects.blink(:cyan, 2)
