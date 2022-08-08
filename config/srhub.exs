import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [{"wlan0", %{type: VintageNetWiFi}}]

# Srhubs have a red/green LED
config :nerves_livebook, :ui, led: "led1:green"
