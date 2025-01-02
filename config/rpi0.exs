import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

config :delux, indicators: %{default: %{green: "ACT"}}

config :nerves, :firmware, fwup_conf: "config/rpi0/fwup.conf"

config :blue_heron,
  transport: [
    device: "/dev/ttyS0",
    speed: 115_200
  ]
