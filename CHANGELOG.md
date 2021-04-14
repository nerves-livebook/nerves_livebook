# Changelog

## v0.4.4

Updates:

* Update to `nerves_system_br v1.15.0` systems (Erlang/OTP 23.2.7)
* Remove Giant Board support since it doesn't support nerves_system_br v1.15.0

## v0.4.3

Updates

* Add support for the Seeed Studio NPi IMX6ULL and Giant Board
* Update to `nerves_system_br v1.14.4` systems

## v0.4.2

WiFi configuration is easier now! To scan for networks, run
`VintageNetWiFi.quick_scan` and then to connect, run
`VintageNetWiFi.quick_configure("ssid", "password")`.

Updates:

* Update Nerves systems to the latest (`nerves_system_br v1.13.7`-based)
* Update `circuits_i2c` so that it includes the new `discover_*` helper
  functions
* Update `vintage_net_wifi` to pull in the "quick" helper functions

## v0.4.1

Updates:

* Update Nerves systems to latest (`nerves_system_br v1.13.5`-based)
* Raspberry Pi 4 now runs in 64-bit mode
* Path autocompletion at IEx prompt

## v0.4.0

Updates:

* Add support for the OSD32MP1
* Update to use `nerves_ssh` and properly support username/password access to
  the device
* Build with Elixir 1.11.1
* Update Nerves systems to latest (`nerves_system_br v1.13.2`-based)

## v0.3.0

Updates:

* Update to Nerves 1.6 and VintageNet/NervesPack

## v0.2.1

Updates:

* Update all Nerves Systems (Raspberry Pi's to v1.9.0 and BBB to v2.4.0)
* Keep symbols so that help is available

## v0.2.0

Updates:

* Update to Nerves 1.5
* Add support for the Raspberry Pi 4
* Support non-USB gadget board networking (like RPi B+, 2, and 3)
* Set the clock via NTP on boards with Ethernet

## v0.1.0

Initial release
