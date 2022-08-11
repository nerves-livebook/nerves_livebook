import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]

# Beagleboards typically have 4 LEDs
#
# beaglebone:green:usr0 is a heartbeat
# beaglebone:green:usr1 is mmc0 activity
# beaglebone:green:usr2 is unset
# beaglebone:green:usr3 is mmc1 activity
config :nerves_livebook, :delux_config, indicators: %{default: %{green: "beaglebone:green:usr2"}}
