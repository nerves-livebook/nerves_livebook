#!/bin/bash
#
# Download & flash Nerves Livebook firmware.
# Run with -h or --help for usage and options.
#
set -euo pipefail

help_text() {
  cat <<EOF
Usage: $(basename "$0") [--help|-h]

A tiny helper to download and flash the latest Nerves Livebook firmware.

Options:
  -h, --help    Show this help message and exit

Environment variables:
  MIX_TARGET             target platform (rpi, rpi0, rpi4, bbb, etc.)
  NERVES_WIFI_SSID       WiFi SSID for provisioning (quote if spaces)
  NERVES_WIFI_PASSPHRASE WiFi passphrase (quote if spaces)
  NERVES_WIFI_FORCE      set WiFi every boot ("true")
  NERVES_SERIAL_NUMBER   custom device serial number

Prerequisites:
  • bash (4+), curl, fwup (requires sudo)
    See: https://github.com/fwup-home/fwup

Resources:
  • Nerves Livebook repo: https://github.com/nerves-livebook/nerves_livebook
EOF
}

echo_heading() {
  printf "\n\033[34m%s\033[0m\n" "$1"
}

echo_success() {
  printf " \033[32m✔ %s\033[0m\n" "$1"
}

echo_error() {
  printf " \033[31m✖ %s\033[0m\n" "$1"
}

ensure_fwup() {
  if ! command -v fwup >/dev/null 2>&1; then
    echo_error "fwup is not installed. Please install it (e.g. via your package manager) and re‑run."
    exit 1
  fi
  echo_success "fwup is installed"
}

ensure_curl() {
  if ! command -v curl >/dev/null 2>&1; then
    echo_error "curl is not installed. Please install it and re‑run."
    exit 1
  fi
  echo_success "curl is installed"
}

select_mix_target() {
  if [ -n "${MIX_TARGET-}" ]; then
    echo_success "Using MIX_TARGET from env: ${MIX_TARGET}"
  else
    echo_heading "Select MIX_TARGET"
    local targets=(
      rpi rpi0 rpi2 rpi3a rpi3 rpi4 rpi5
      bbb x86_64 osd32mp1 grisp2 mangopi_mq_pro
    )
    PS3="Enter number: "
    select tgt in "${targets[@]}"; do
      if [ -n "$tgt" ]; then
        MIX_TARGET=$tgt
        break
      fi
    done

    echo_success "→ MIX_TARGET=${MIX_TARGET}"
  fi
}

download_firmware() {
  echo_heading "Downloading firmware for ${MIX_TARGET}"
  local url="https://github.com/nerves-livebook/nerves_livebook/releases/latest/download/nerves_livebook_${MIX_TARGET}.fw"
  FW_IMAGE="$TMPDIR/nerves_livebook_${MIX_TARGET}.fw"
  if ! curl -fsSL "$url" -o "$FW_IMAGE"; then
    echo_error "Failed downloading ${url}"
    exit 1
  fi
  echo_success "Saved to ${FW_IMAGE}"
}

configure_provisioning() {
  echo_heading "Configuring provisioning options"
  PROVISIONING_ENV=()

  if [ -n "${NERVES_WIFI_SSID-}" ]; then
    echo_success "SSID from env: ${NERVES_WIFI_SSID}"
    PROVISIONING_ENV+=("NERVES_WIFI_SSID=${NERVES_WIFI_SSID}")
  else
    read -rp "WiFi SSID (blank to skip): " ssid
    if [ -n "$ssid" ]; then
      PROVISIONING_ENV+=("NERVES_WIFI_SSID=${ssid}")
    fi
  fi

  if [ -n "${NERVES_WIFI_PASSPHRASE-}" ]; then
    echo_success "Passphrase from env"
    PROVISIONING_ENV+=("NERVES_WIFI_PASSPHRASE=${NERVES_WIFI_PASSPHRASE}")
  else
    read -rp "WiFi passphrase (blank to skip): " psk
    if [ -n "$psk" ]; then
      PROVISIONING_ENV+=("NERVES_WIFI_PASSPHRASE=${psk}")
    fi
  fi

  read -rp "Force WiFi each boot? [y/N]: " wifi_force_answer
  case "$wifi_force_answer" in
  [Yy]*)
    PROVISIONING_ENV+=("NERVES_WIFI_FORCE=true")
    ;;
  *) ;;
  esac

  if [ -n "${NERVES_SERIAL_NUMBER-}" ]; then
    echo_success "Serial from env: ${NERVES_SERIAL_NUMBER}"
    PROVISIONING_ENV+=("NERVES_SERIAL_NUMBER=${NERVES_SERIAL_NUMBER}")
  else
    read -rp "Custom serial# (blank for default): " serial_answer
    if [ -n "$serial_answer" ]; then
      PROVISIONING_ENV+=("NERVES_SERIAL_NUMBER=${serial_answer}")
    fi
  fi

  echo_success "Provisioning environment prepared"
}

flash_card() {
  echo_heading "Ready to flash Nerves Livebook"
  echo "→ Firmware file : $(basename "$FW_IMAGE")"
  echo "→ File path     : $FW_IMAGE"

  local auto_dev=""
  until auto_dev=$(fwup -z 2>/dev/null); do
    echo_error "fwup did not detect any removable device."
    read -rp "Please insert your SD card or USB adapter, then press Enter to retry..."
  done

  echo_success "fwup will target: ${auto_dev}"

  read -rp "Proceed to flash this firmware? [y/N]: " proceed_answer
  case "$proceed_answer" in
  [Yy]*)
    echo_heading "Launching fwup"
    sudo "${PROVISIONING_ENV[@]}" fwup "$FW_IMAGE"
    echo_success "Your Nerves Livebook card is ready!"
    echo
    echo "Next steps:"
    echo "  1. Eject, insert into your device."
    echo "  2. Power on and ensure network connectivity."
    echo "  3. Visit http://nerves.local (password: nerves)."
    ;;
  *)
    echo_error "Aborted by user"
    exit 1
    ;;
  esac
}

main() {
  case "${1:-}" in
  -h | --help)
    help_text
    exit 0
    ;;
  "") ;;
  *)
    echo_error "Unknown option: $1"
    help_text
    exit 1
    ;;
  esac

  TMPDIR=$(mktemp -d)
  trap 'echo_success "Removing temporary directory: $TMPDIR"; rm -rf "$TMPDIR"' EXIT

  ensure_fwup
  ensure_curl
  select_mix_target
  download_firmware
  configure_provisioning
  flash_card
}

main "$@"
