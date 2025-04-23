# Quickstart: Flash Nerves Livebook

This guide shows you how to download and flash the latest Nerves Livebook
firmware in one simple flow. By the end, you’ll have Livebook running on your
device and be ready to explore tutorials in your browser.

---

## Evaluate in seconds

Run this single command to download, provision, and flash the latest firmware:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/nerves-livebook/nerves_livebook/main/scripts/flash_livebook.sh)
```

You’ll be prompted to:

- Select your `MIX_TARGET` (e.g. `rpi0`, `rpi4`, `bbb`)
- Enter WiFi SSID & passphrase
- Optionally set a custom serial number
- Insert your SD card when asked

This one-liner installer fetches and runs the flashing helper, cleans up after
itself, and leaves you with a ready-to-go Livebook card. If you’d like to review
or customize the script first, continue by cloning the repository in the next
section.

---

## Prerequisites

1. A supported board (Raspberry Pi Zero/Zero W, Pi 4, BeagleBone Black, etc.)
2. A micro‑SD card and an SD‑card reader (built‑in slot or USB adapter)
3. On your host machine:
   - bash (4+)
   - curl
   - fwup (requires `sudo`; see https://github.com/fwup-home/fwup)

---

## Clone the repository

If you want to inspect or tweak the flashing script before running it, clone
the repo:

```bash
git clone https://github.com/nerves-livebook/nerves_livebook.git
cd nerves_livebook
```

By cloning, you can open `scripts/flash_livebook.sh` in your editor, make any
adjustments or integrations, and then execute it locally.

---

## Flash with one command

Make the helper script executable:

```bash
chmod +x scripts/flash_livebook.sh
```

Then run:

```bash
./scripts/flash_livebook.sh
```

You will be prompted to:

- Select your `MIX_TARGET` (e.g. `rpi0`, `rpi4`, `bbb`)
- Enter WiFi SSID and passphrase
- Optionally set a custom serial number
- Insert your SD card when asked

The script will download the latest `.fw`, provision it, wait for your card,
and invoke `sudo fwup …` for you.

---

## Verify Livebook

1. Eject the SD card and insert it into your board
2. Power on and connect to your network
3. Open http://nerves.local in your browser
4. Log in with password: nerves

You should see the Livebook home page and built‑in tutorials.

---

## Next steps

### Explore the built‑in tutorials

Click any example notebook. Run the code cells to see hardware I/O, GPIO
examples, and more—no additional setup required.

### Build your own firmware

1. Create a new project skeleton:
   ```bash
   mix nerves.new my_nerves_app
   cd my_nerves_app
   ```
2. Open `lib/my_nerves_app.ex` in your editor and tweak the example (e.g. blink an LED).
3. Fetch deps and compile:
   ```bash
   mix deps.get
   mix firmware
   ```
4. Generate an upload script:
   ```bash
   mix firmware.gen.script
   ```

### Deploy Over‑the‑Air

With your board on the network, run:

```bash
./upload.sh nerves.local
```

This sends your newly built firmware straight to the device—no SD card required.
