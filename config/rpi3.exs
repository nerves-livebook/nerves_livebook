import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

config :delux, indicators: %{default: %{green: "ACT"}}

config :blue_heron,
  transport: [
    device: "/dev/ttyS0",
    speed: 115_200
  ]
