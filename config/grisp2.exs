import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

# The GRiSP 2 has two RGB LEDs and a green LED
#
# RGB1: grisp-rgb1-red, grisp-rgb1-green, grisp-rgb1-blue
# RGB2: grisp-rgb2-red, grisp-rgb2-green, grisp-rgb2-blue
# phycore-green - defaults to heartbeat on boot

config :nerves_livebook, :delux_config,
  indicators: %{
    default: %{red: "grisp-rgb1-red", green: "grips-rgb1-green", blue: "grisp-rgb1-blue"}
  }
