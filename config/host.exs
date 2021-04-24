import Config

# Configure Livebook
config :livebook, LivebookWeb.Endpoint,
  url: [host: "localhost"],
  http: [ip: {127, 0, 0, 1}, port: 8080],
  code_reloader: false,
  server: true,
  secret_key_base: "9hHHeOiAA8wrivUfuS//jQMurHxoMYUtF788BQMx2KO7mYUE8rVrGGG09djBNQq7"

config :livebook,
  root_path: "priv/livebooks"
