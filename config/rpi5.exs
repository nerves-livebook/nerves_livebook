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

# Apply generic WiFi configurations supporting both WPA2 and WPA3.
config :vintage_net_wifi, :quick_configure, &VintageNetWiFi.Cookbook.generic/2

# Override the console port to use. The default is HDMI, but the RPi debug
# console port is convenient too (ttyAMA10).
# config :nerves, :erlinit,
#    ctty: "ttyAMA10"
