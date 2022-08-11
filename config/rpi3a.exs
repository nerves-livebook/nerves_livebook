import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

config :nerves_livebook, :delux_config, indicators: %{default: %{green: "led0"}}

config :nerves, :firmware, fwup_conf: "config/rpi3a/fwup.conf"
