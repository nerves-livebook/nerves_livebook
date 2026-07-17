import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

config :delux, indicators: %{default: %{green: "ACT"}}

# The RPi5 supports WPA3 so this enables quick_configure to create WiFi
# configurations that support both WPA2 and WPA3.
config :vintage_net_wifi, :quick_configure, &VintageNetWiFi.Cookbook.generic/2

# See https://github.com/nerves-networking/vintage_net_wifi/pull/315
config :vintage_net_wifi,
  cookbook_extras: %{
    generic: %{vintage_net_wifi: %{sae_pwe: 2}},
    wpa3_sae: %{vintage_net_wifi: %{sae_pwe: 2}}
  }

# See mix.exs
# config :nx, default_backend: NxEigen.Backend

# Override the console port to use. The default is HDMI, but the RPi debug
# console port is convenient too (ttyAMA10).
# config :nerves, :erlinit,
#    ctty: "ttyAMA10"
