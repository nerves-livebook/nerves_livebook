import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [{"wlan0", %{type: VintageNetWiFi}}]

# Srhubs have a red/green LED
config :nerves_livebook, :delux_config,
  indicators: %{default: %{red: "led1:red", green: "led1:green"}}
