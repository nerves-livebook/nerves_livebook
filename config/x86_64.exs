import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  config: [
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}}
  ]

# No LEDs since we can't depend on one being available on x86
config :nerves_livebook, :delux_config, indicators: %{default: %{}}
