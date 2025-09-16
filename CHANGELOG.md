# Changelog

## v0.17.0 - 2025-09-16

* Updates
  * Update to [Livebook v0.17.2](https://github.com/livebook-dev/livebook/releases/tag/v0.17.2)
  * Update Nerves systems to [nerves_system_br v1.31.7](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.31.7)
  * Update all dependencies

## v0.15.6 - 2025-04-04

* Fixes
  * Fix regression causing an UndefinedFunctionError for `Mix.install_project_dir/0`. Thanks to @gworkman for quickly reporting

## v0.15.5 - 2025-04-03

* Updates
  * Update to [Livebook v0.15.5](https://github.com/livebook-dev/livebook/releases/tag/v0.15.5)
  * Update Nerves systems to [nerves_system_br v1.30.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.30.0)
  * Update all dependencies

## v0.14.2 - 2025-01-22

* Updates
  * Update Nerves systems to [nerves_system_br v1.29.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.29.3)
  * Add support for the RPi CM5 and other BCM2712 D0 silicon RPi5's
  * Update to Elixir 1.18.2 and Erlang/OTP 27.2
  * Update all dependencies

## v0.14.1 - 2024-11-28

* Updates
  * Update to [Livebook v0.14.5](https://github.com/livebook-dev/livebook/releases/tag/v0.14.5)
  * Update Nerves systems to [nerves_system_br v1.29.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.29.1)
  * Update all dependencies
  * Added notebook for connecting to NervesHub (Thanks @lawik)

## v0.14.0 - 2024-9-04

* Updates
  * Update to [Livebook v0.14.0](https://github.com/livebook-dev/livebook/releases/tag/v0.14.0)
  * Update Nerves systems to [nerves_system_br v1.28.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.28.3)
  * Add `vintage_net_qmi` to dependencies to use some cellular modems on Raspberry Pis and Beaglebones with USB host ports. These boards include QMI device drivers in this release.
  * Update all dependencies
  * Fix tflite sample notebook (Thanks @mnishiguchi)

## v0.13.0 - 2024-7-14

* Updates
  * Update to [Livebook v0.13.3](https://github.com/livebook-dev/livebook/releases/tag/v0.13.3). Also see the [v0.13.0 changes](https://github.com/livebook-dev/livebook/releases/tag/v0.13.0)
  * Update to Elixir 1.17.2 and Erlang/OTP 27.0
  * Update Nerves systems to [nerves_system_br v1.28.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.28.1)
  * Update all dependencies to latest versions
  * Remove `picam` from 32-bit Raspberry Pi releases due to the switch from MMAL to `libcamera`

## v0.12.3 - 2024-4-7

* Updates
  * Update Nerves systems to `nerves_system_br v1.27.0` (Erlang/OTP 26.2.3,
    Buildroot 2024.02)
  * Switch back to WPA2-only WiFi support with
    `VintageNetWiFi.quick_configure/2` to fix issues on BBB and GRiSP2
  * Fix regression that prevented WiFi networks from being provisioned on the
    MicroSD card
  * Removed `srhub` target due to perceived lack of use. If this is not true,
    please open an issue and we'll include it again.
  * Update all dependencies to latest versions

## v0.12.2 - 2024-2-18

* Updates
  * Update `vintage_net_wifi` to fix an issue connecting to some WPA2 networks
    using `VintageNetWiFi.quick_configure/2`
  * Enable TFLite support on Raspberry Pi Model B and Raspberry Pi Zeros now
    that it has ARMv6 support. (@cocoa-xu)
  * Update Nerves systems to `nerves_system_br` 1.25.1 versions (Erlang 26.2.2)
  * Update all dependencies to latest versions

## v0.12.1 - 2024-1-21

* Updates
  * Fix LED naming changes from Linux kernel update that ended up breaking RPi
    Zero, 2, and 3.
  * Update Nerves systems to nerves_system_br 1.24.1 versions (Erlang 26.2.1)
  * Add WPA3 support for devices with WiFi modules that support it (currently
    only BeagleBone's with WiLink modules)
  * Update all dependencies to latest versions
  * Fix diagnostics notebook (@mnisiguchi)
  * Fix firmware update notebook (@5avage)

## v0.12.0 - 2024-1-1

Happy New Year!

* Updates
  * Update Livebook to [v0.12.1](https://github.com/livebook-dev/livebook/releases/tag/v0.12.1)
  * Fix Raspberry Pi 3 regression in v0.11.1
  * Update Elixir to 1.16.0
  * SBOM generation is temporarily off pending a PR getting merged

## v0.11.1 - 2023-12-19

* Updates
  * Add 64-bit RPi Zero 2W (`rpi0_2`). 32-bit mode was supported before via
    `rpi3a`, but this enables the JIT
  * Add RPi 5 (`rpi5`). This port is current experimental
  * Update Nerves systems to nerves_system_br 1.25.2 versions
    * Erlang 26.1.2
    * Buildroot 2023.08.4
    * Linux 6.1 on all Raspberry Pi and BBB ports
  * Update Elixir to 1.15.7
  * Update all dependencies to their latest versions

## v0.11.0 - 2023-10-09

* Updates
  * Update Livebook to [v0.11.0](https://github.com/livebook-dev/livebook/releases/tag/v0.11.0)
  * Update Nerves systems to nerves_system_br 1.24.1 versions
    * Erlang 26.1.1
    * Buildroot 2023.05.3
  * Update Elixir to 1.15.6
  * Update all dependencies to their latest versions

## v0.10.1 - 2023-07-29

* Updates
  * Add `:tflite_elixir` back since it works again
  * Update Nerves systems to nerves_system_br 1.23.2 versions to get CTRL+R fix
    for ssh sessions (and more).
  * Improve PMOD support on GRiSP 2
  * Update Elixir to 1.15.4

## v0.10.0 - 2023-07-14

* Updates
  * Update Livebook to [v0.10.0](https://github.com/livebook-dev/livebook/releases/tag/v0.10.0)
  * Update Nerves systems to nerves_system_br 1.23.1 versions. This includes:
    * Erlang 26.0.2
    * Support for all Raspberry Pi Cameras via libcamera on the RPi4
    * Buildroot 2023.02.2
    * Linux updates on various systems
  * Update Elixir to 1.15.2
  * Update all dependencies to their latest versions

NOTE: `:tflite_elixir` is temporily removed due to build errors.

## v0.9.1 - 2023-05-14

* Updates
  * Update Livebook to [v0.9.2](https://github.com/livebook-dev/livebook/releases/tag/v0.9.2)
  * Include TFLite (`:tflite_elixir`) for all devices that support TensorFlow
    Lite (all but Raspberry Pi 1 and Raspberry Pi Zero). See the `tflite.livemd`
    sample to a quick intro. Thanks to Masatoshi Nishiguchi for this.
  * Update all dependencies to their latest versions.

## v0.9.0 - 2023-04-05

* Updates
  * Update Livebook to [v0.9.1](https://github.com/livebook-dev/livebook/releases/tag/v0.9.1)
  * Update Nerves systems to nerves_system_br 1.22.5 versions. This includes
    Erlang 25.3 and fixes to the Raspberry Pi 3 to support TensorFlow Lite.
    (TFLite isn't built into Nerves Livebook yet)
  * Update all dependencies to their latest versions.

* Fixes
  * Fixed LEDs on SRHub images (Thanks to Eric Oestrich)

## v0.8.3 - 2023-03-12

* Updates
  * Generate and post docs to hex.pm so that hyperlinks work when calling
    NervesLivebook functions
  * Update Nerves systems to nerves_system_br 1.22.3 versions. This includes
    Erlang 25.2.3 and an update for Rust support. Libraries using Rust aren't
    included yet due to an issue on 32-bit platforms, but will likely be
    included in the next release.
  * Update all dependencies to their latest versions.

## v0.8.2 - 2023-02-11

* Updates
  * Update Livebook to [v0.8.1](https://github.com/livebook-dev/livebook/releases/tag/v0.8.2)
  * Update all dependencies to latest (Nx 0.5.0, RingLogger 0.9.0, Toolshed
    0.3.0, VintageNet 0.13.0)
  * Configure the Erlang compiler for deterministic builds

## v0.8.1 - 2023-01-17

IMPORTANT: The MangoPi MQ Pro has a major update that makes it non-backwards
compatible despite this release's version number. This is due to hacks to
support it being removed that unfortunately caused the MicroSD card contents to
be changed. Please move your work off your current MicroSD cards and re-flash
it. Upgrading is not supported.


* Updates
  * Update Nerves systems to `nerves_system_br` 1.22.1 versions (Buildroot 2022.11)
  * Update MangoPi MQ Pro to Linux 6.1
  * Switch MangoPi MQ Pro from Musl Libc to Glibc (better Rust support)
  * Update all toolchains to use GCC 12.2
  * Update all provided mix libraries to their latest

## v0.8.0 - 2022-12-19

* Updates
  * Update Livebook to [v0.8.0](https://github.com/livebook-dev/livebook/releases/tag/v0.8.0)
  * Reduced logger level to warning to reduce clutter when evaluating cells.
    This is a the same default level as regular Livebook.
  * Support the shutdown button. This will gracefully power off your device.
    Note that Nerves Livebook syncs notebooks to minimizing losing notebook
    changes already, but this is an additional way to make sure everything has been
    flushed to storage when you're done.
  * Update Nerves systems to `nerves_system_br` 1.21.6 versions (Erlang/OTP 25.2)
  * Update all provided mix libraries to their latest.

## v0.7.2 - 2022-11-07

* Updates
  * Update Livebook to [v0.7.2](https://github.com/livebook-dev/livebook/releases/tag/v0.7.2)
  * Update Nerves systems to `nerves_system_br` 1.21.2 versions
  * Fix hyperlinks and move more pages to learn sections (Thanks @mnishiguchi)

## v0.7.0 - 2022-10-09

* Updates
  * Update Livebook to [v0.7.1](https://github.com/livebook-dev/livebook/releases/tag/v0.7.1)
  * Update Nerves systems to `nerves_system_br` 1.20.6 versions
  * Update Nerves to v1.9.1

## v0.6.5 - 2022-08-29

* Updates
  * Add WiFi configuration to explore section to make it easier to find
  * Use the new `Delux` library to control the LED. This will enable better
    feedback for what Livebook is doing when you can't see the webpage
  * Blink LED to show that the RPi0 is booting since it takes so long to start.
  * Add the `Pinout` library as a convenience for getting board pinouts.
  * Add libraries for devices that support cellular modems (only `srhub` now)

## v0.6.4 - 2022-08-08

* Updates
  * Update Livebook to [v0.6.3](https://github.com/livebook-dev/livebook/releases/tag/v0.6.3)
  * Update Nerves systems to `nerves_system_br` 1.20.4 versions. This includes
    Erlang/OTP 25.0.3, Buildroot 2022.05, and GCC 11.3.
  * Fix warnings when building in host mode. (Thanks @axelson)
  * Update dependencies to latest versions
  * Add preliminary support for srhub devices

## v0.6.3 - 2022-07-08

* Updates
  * Update Livebook to [v0.6.2](https://github.com/livebook-dev/livebook/releases/tag/v0.6.2)
  * Support the 64-bit RISC-V MangoPi MQ Pro
  * Change the WiFi regulatory domain default from `US` to the global region (`00`)
  * Update Nerves systems to `nerves_system_br` 1.20.3 versions. This includes
    Erlang/OTP 25.0.2, Buildroot 2022.05, and GCC 11.3.

## v0.6.2 - 2022-05-26

* Updates
  * Update to Erlang 25.0 - Enables JIT on Raspberry Pi 4!
  * Update Nerves systems to `nerves_system_br` 1.19.0 versions to bring in
    security and bug fixes

## v0.6.1 - 2022-05-20

* Updates
  * Include `:kino_vega_lite` so that graphs render again. (Thanks @petermm)
  * Improve WiFi configuration book (Thanks @petermm)

## v0.6.0 - 2022-05-07

* Updates
  * Update Livebook to [v0.6.1](https://github.com/livebook-dev/livebook/releases/tag/v0.6.1)

## v0.5.7 - 2022-03-18

* Updates
  * Update to Erlang 24.3.2
  * Various modest boot time improvements in dependent libraries

## v0.5.6 - 2022-03-03

* Updates
  * Various small improvements for the GRiSP 2
  * Add support for the Beaglebone Green Gateway (bbb target)
  * Update to Erlang 24.2.2

## v0.5.5 - 2022-02-28

* Updates
  * Add experimental support for GRiSP 2. See README.md for installation.

## v0.5.4 - 2022-02-18

* Updates
  * Update Nerves Systems to `nerves_system_br` 1.18.4 versions. This brings in
    Buildroot and Erlang patch releases.
  * Add `picam` for devices that support it (Raspberry Pi Zero, A, B, 2, and 3).

* Fixes
  * Fix import via file upload

## v0.5.3 - 2022-02-05

* Updates
  * Pulled in a fix for scanning WiFi access points when an Eero mesh system is
    nearby.

## v0.5.2 - 2022-01-31

* Updates
  * Update Livebook to [v0.5.2](https://github.com/livebook-dev/livebook/releases/tag/v0.5.2)
  * Turn on an LED when networking on the device is ready. This isn't perfect
    for showing status, but aims to be more helpful than the current lack of
    feedback.

## v0.5.1 - 2022-01-25

* Updates
  * Fix regression in v0.5.0 with plotting graphs with VegaLite
  * Update Circuits.SPI to pull in support for lsb-first devices

## v0.5.0 - 2022-01-20

* Updates
  * Update Livebook to [v0.5.1](https://github.com/livebook-dev/livebook/releases/tag/v0.5.1)

## v0.4.2 - 2022-01-16

* Updates
  * Add `req` to the built-in hex packages
  * Update Nerves Systems to `nerves_system_br` 1.18.3 versions. This brings in
    a `cpufreq` fix, OpenMP support, and CMake support
  * Update Elixir to 1.13.2

## v0.4.1 - 2021-12-31

* Updates
  * Update Livebook to [v0.4.1](https://github.com/livebook-dev/livebook/releases/tag/v0.4.1)
  * Update Elixir to 1.13.1
  * Update Nerves Systems to use Erlang 24.2, Buildroot 2021.11 and
    miscellaneous platform-specific bug fixes and improvements.
  * Update various other dependencies to their latest versions

## v0.4.0 - 2021-12-05

* Updates
  * Update Livebook to [v0.4.0](https://github.com/livebook-dev/livebook/releases/tag/v0.4.0)
  * Update Elixir to 1.13.0
  * Update Nerves Systems to use Erlang 24.1.7, Buildroot 2021.08.2 and
    miscellaneous platform-specific bug fixes and improvements.

## v0.3.2 - 2021-11-13

* Updates
  * Update Livebook to v0.3.2
  * Simplify ssh login to not care about the username
  * Update Nerves systems. This brings in support for the new Raspberry Pi Zero
    2 W. Use the `rpi3a` version for the Zero 2 W.

## v0.3.1 - 2021-10-27

* Updates
  * Update Livebook to v0.3.1

 ## v0.3.0 - 2021-10-19

* Updates
  * Update Livebook to v0.3.0
  * Include ExUnit to support notebooks with tests

## v0.2.27 - 2021-10-16

* Updates
  * Update to Erlang 24.1.2 and Buildroot 2021.08.1
  * Update Livebook to latest. Pulls in dynamic favicon.

## v0.2.26 - 2021-10-09

* Updates
  * Fix boot issue on Seeed Studio's NPi iMX6ULL board
  * Selectively include BlueHeron since it doesn't work on all boards

## v0.2.25 - 2021-10-07

* Updates
  * Initial Bluetooth support is available for the Raspberry Pi Zero W and 3B.
    If you have either of these boards, take a look at
    `bluetooth/ble_device_with_nerves.livemd`. Thanks to Troels Brødsgaard for
    contributing this.
  * Include Nx so that the the Nx tutorial works
  * Update MdnsLite and make the advertised services look pretty on devices that
    support mDNS. The default is to show up as "Nerves Livebook" and advertise
    HTTP, SSH, SFTP, and Erlang distribution.

## v0.2.24 - 2021-10-05

The default location for notebooks on the device has changed from
`/data/livebooks` to `/data/livebook` for consistency. If you're upgrading to
this release, the old directory will be kept in case any modifications were made
to notebooks there.

* Updates
  * Update Livebook from `v0.2.3` to [`main@d8a7af62`](https://github.com/livebook-dev/livebook/blob/d8a7af62e78c664b667cb30c8430a1b56e412500/CHANGELOG.md).
    See the unreleased items in the link for Livebook changes.
  * Redirect to the device's specific hostname when using `nerves.local` to
    connect. This makes it more obvious which device you're connected to when
    multiple Nerves Livebook devices are accessible.

## v0.2.23 - 2021-10-01

* Updates
  * Several networking notebook additions and improvements. Thanks to Jon
    Carstens for these.
  * Pull in a subtle mDNS/DNS issue lookup issue that affected using .local
    addresses on some networks
  * Pull in Bluetooth support fixes. BLE works on Raspberry Pi Zeros and
    Raspberry Pi 3s now, but it's not convenient and there aren't any sample
    notebooks. We hope to change that soon.
  * You can transfer files using `scp` in addition to `sftp` from Nerves
    Livebook devices now.

## v0.2.22

* Updates
  * Upgrade to `nerves_system_br` `1.17.0`-based systems. These include Erlang
    24.1 and Buildroot 2021.08.

## v0.2.21

* Updates
  * Update all URLs to point to the `nerves_livebook` home on the `livebook-dev`
    GitHub repository

## v0.2.20

* Updates
  * The Raspberry Pi 4 USB-C port can now be used for power and data. This is
    similar to the Raspberry Pi Zero, 3A and BBB.
  * Minor updates to a variety of packages

## v0.2.19

* Updates
  * Use new Nerves MOTD for ssh logins

## v0.2.18

* Updates
  * Livebook 0.2.3
  * Update to MdnsLite 0.8.0 and enable support for using mDNS (.local)
    addresses with Erlang distribution and more
  * Update various other Nerves dependencies

## v0.2.17

* Updates
  * Make Erlang distribution predictable. It's now
    `livebook@nerves-<device id>.local`. From within Livebook, you can see the
    name by going to the settings tab. This is an mDNS name and will work even
    if the IP address to the device changes. It only requires an mDNS client on
    your computer which is included by default on MacOS and usually on Linux.

## v0.2.16

* Updates
  * Support provisioning WiFi when creating the MicroSD card. See `README.md`
    for how to pass parameters when calling `fwup`.
  * Check that dependencies passed to `Mix.install/1` are compatible with what's
    included in Nerves Livebook. Installation isn't supported yet, but this
    update makes it possible to include `Mix.install/1` calls in your livebooks
    for when it does work.

## v0.2.15

* Updates
  * Minor version bumps on many dependencies - no new features

## v0.2.14

* Updates
  * Update to OTP 24-based Nerves systems
  * Livebook 0.2.2

## v0.2.13

* Updates
  * Update Livebook to 0.1.2
  * The `vega_lite` and `kino` packages are available so it's now possible to
    experiment with plotting sensor data. Note that `Mix.install` doesn't work
    yet so if you're trying out a notebook that uses `vega_lite`, just uncomment
    the `Mix.install` parts for now.

## v0.2.12

* Updates
  * Organize sample livebooks into directories so that they're easier to find.
    More changes are coming. Thanks to DJ Carpenter for spearheading the effort
    better organize this project.
  * Add a delta firmware update livebook. This livebook can't be used just yet.
    It needs a release to update to. Once v0.2.13 is available, it will work.

## v0.2.11

* Updates
  * Add NervesKey (ATECC508A/608) provisioning example. Thanks to Alex McLain
    for contributing this.
  * Building delta firmware updates on CI. This lays the groundwork for future
    livebooks.

## v0.2.10

* Updates
  * Update to Livebook 0.1.1
  * Add PWM example using Pigpiox for Raspberry Pis. Thanks to DJ Carpenter for
    contributing this.

## v0.2.9

* Updates
  * Update to Elixir 1.12.0 and Livebook 0.1.0
  * Various BMP280 Livebook and library updates

## v0.2.8

Community update release!

* Updates
  * Thanks to Jonatan Klosko, upstream Livebook now supports embedded mode so we
    can use it on Nerves without patching it. This release has zero custom
    Livebook patches for Nerves.
  * DJ Carpenter has started reorganizing the samples directory to make it
    easier to find examples. He also added a GPIO button example.
  * Masatoshi Nishiguchi has updates to the BMP280
    temperature/humidity/barometric sensor example too

## v0.2.7

* Updates
  * Add Circuits.GPIO example from DJ Carpenter
  * Add BMP280 example from Masatoshi Nishiguchi

## v0.2.6

* Updates
  * Use Elixir 1.12.0-rc.1. This enables some Livebook features that I haven't
    tested yet, but look cool.
  * Update Livebook to the latest to pull in user profiles

## v0.2.5

* Updates
  * Verify firmware signatures in `firmware_update.livemd`

## v0.2.4

* Updates
  * Start signing firmware updates and add info on how. This doesn't check
    firmware signatures yet. That will be the next release.

## v0.2.3

* Updates
  * Minor firmware update livebook improvements

## v0.2.2

* Updates
  * Add welcome
  * Update Livebook to latest

## v0.2.1

* Bug fixes
  * Clean up /data/livebooks. This may be worth a complete re-flash to clean up
    the MicroSD card.

* Updates
  * Update Livebook to try import feature

## v0.2.0

This release no longer copies the built-in Livebooks to the data partition.
They're no symlinked so that they remain read-only and update on firmware
updates. You now have to fork them to run them.

* New features
  * A firmware update example

## v0.1.1

Initial CI-built release

## v0.1.0

Initial release
