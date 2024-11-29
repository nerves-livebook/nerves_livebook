import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

config :delux, indicators: %{default: %{green: "ACT"}}

# The RPi5 doesn't support WPA3 yet, but it also doesn't fail with the generic
# configuration. This will enable WPA3 support when it's available.
config :vintage_net_wifi, :quick_configure, &VintageNetWiFi.Cookbook.generic/2

config :nx, default_backend: EXLA.Backend
