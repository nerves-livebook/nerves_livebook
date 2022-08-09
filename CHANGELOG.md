# Changelog

## v0.6.4 - 2022-08-08

* Updates
  * Update Livebook to [v0.6.3](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v063-2022-07-13)
  * Update Nerves systems to `nerves_system_br` 1.20.4 versions. This includes
    Erlang/OTP 25.0.3, Buildroot 2022.05, and GCC 11.3.
  * Fix warnings when building in host mode. (Thanks @axelson)
  * Update depencies to latest versions
  * Add preliminary support for srhub devices

## v0.6.3 - 2022-07-08

* Updates
  * Update Livebook to [v0.6.2](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v062-2022-06-30)
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
  * Update Livebook to [v0.6.1](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v061-2022-05-06)

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
  * Update Livebook to [v0.5.2](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v052-2022-01-27)
  * Turn on an LED when networking on the device is ready. This isn't perfect
    for showing status, but aims to be more helpful than the current lack of
    feedback.

## v0.5.1 - 2022-01-25

* Updates
  * Fix regression in v0.5.0 with plotting graphs with VegaLite
  * Update Circuits.SPI to pull in support for lsb-first devices

## v0.5.0 - 2022-01-20

* Updates
  * Update Livebook to [v0.5.1](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v051-2022-01-20)

## v0.4.2 - 2022-01-16

* Updates
  * Add `req` to the built-in hex packages
  * Update Nerves Systems to `nerves_system_br` 1.18.3 versions. This brings in
    a `cpufreq` fix, OpenMP support, and CMake support
  * Update Elixir to 1.13.2

## v0.4.1 - 2021-12-31

* Updates
  * Update Livebook to
    [v0.4.1](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v041-2021-12-09)
  * Update Elixir to 1.13.1
  * Update Nerves Systems to use Erlang 24.2, Buildroot 2021.11 and
    miscellaneous platform-specific bug fixes and improvements.
  * Update various other dependencies to their latest versions

## v0.4.0 - 2021-12-05

* Updates
  * Update Livebook to
    [v0.4.0](https://github.com/livebook-dev/livebook/blob/main/CHANGELOG.md#v040-2021-12-05)
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
  * Update Livebook from `v0.2.3` to
    [`main@d8a7af62`](https://github.com/livebook-dev/livebook/blob/d8a7af62e78c664b667cb30c8430a1b56e412500/CHANGELOG.md).
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
