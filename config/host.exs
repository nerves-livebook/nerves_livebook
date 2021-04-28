import Config

# Configure Livebook
config :livebook, LivebookWeb.Endpoint,
  url: [host: "localhost"],
  http: [ip: {127, 0, 0, 1}, port: 8080],
  code_reloader: false,
  server: true,
  secret_key_base: "9hHHeOiAA8wrivUfuS//jQMurHxoMYUtF788BQMx2KO7mYUE8rVrGGG09djBNQq7"

config :livebook,
  root_path: "priv"

config :nerves_runtime,
  target: "host"

# Configure Nerves runtime dependencies for the host
config :nerves_runtime, Nerves.Runtime.KV.Mock, %{"nerves_fw_devpath" => "/dev/will_not_work"}

config :vintage_net,
  resolvconf: "/dev/null",
  persistence_dir: "./test_tmp/persistence",
  path: "#{File.cwd!()}/test/fixtures/root/bin"

# Turn off ntp
config :nerves_time, servers: []
