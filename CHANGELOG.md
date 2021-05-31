# Changelog

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
