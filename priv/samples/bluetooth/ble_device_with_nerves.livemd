# Build a Bluetooth Low Energy Device with Nerves

## Hello, Bluetooth!

You've probably interacted with a device using Bluetooth before.
Maybe your headphones or your car's stereo uses Bluetooth.
But did you know that you can use Bluetooth with your Nerves device?
You can! [Blue Heron](https://hex.pm/packages/blue_heron) is an Elixir library
for Bluetooth Low Energy communication.

Here, we'll use Blue Heron to build a device that lets nearby people view and update the firmware
configuration settings and reboot the device.

### A few basics you need to know about Bluetooth

The release of Bluetooth 4.0 in 2010 saw the introduction of Bluetooth Low Energy (Bluetooth LE, or simply BLE).
The standard describes how BLE devices discover each other, how they connect, and how they interact.
It uses a particular terminology, which you'll see when you're using Blue Heron.
This primer will give you a quick rundown of the terms before we get started.

**Device roles**

In BLE, a device can operate in 1 of 4 modes:

* Broadcaster:
  Broadcasts information for anyone to see. Could be a temperature sensor that broadcasts its measurements,
  or an iBeacon. The act of broadcasting is called advertising.
* Observer:
  Listens for broadcasts. This is done by either actively or passively scanning for advertising packets.
* Peripheral:
  Like the Broadcaster, a Peripheral will broadcast advertising packets.
  Unlike the Broadcaster, these packets will include connection information.
  This lets other devices of type Central (see below) establish a connection with the Peripheral,
  after which the connected devices can perform client/server exchanges of data.
* Central:
  Like the Observer, a Central will scan for advertising packets.
  Unlike the Observer, the Central may attempt to establish connections with advertising Peripherals.

Typically, your phone acts as a Central, while your headphones or your car stereo acts as a Peripheral.

**Advertising data**

There are several kinds of data that Broadcasters and Peripherals may advertise.
Examples include:

* Identifying information, like a device name.
* The services that the device implements (like heart rate monitor, or device battery).
* Service Data, like temperature measurements or other sensor values.
* Manufacturer specific data, which can really be anything (for example, this is used for iBeacons).

**Client and server**

The protocol that governs interactions between connected devices is known as GATT (Generic Attribute Protocol).

When connected, a Central and a Peripheral typically act as a GATT client and a GATT server, respectively.
You can think of them as a web browser and a web server. The Central (GATT client / web browser) will send requests
to the Peripheral (GATT server / web server) to either read or write data.

For example, a Peripheral with the device battery service will allow a connected Central
to read the battery level indicator.

**Service discovery**

Connections can be established between any mix of Central and Peripheral.
The advertising packets sent by the Peripheral may contain some hint of what the device
is or what it can do, but this may not tell the complete story.
Thus, after connecting, the Central will often perform a sevice discovery procedure,
which lets the Central learn about the complete functionality of the Peripheral.

**Services and characteristics**

The functionality of a Peripheral is called the **device profile**. The profile consists of a list of services,
and each service can have one or more characteristics.
For example, the device battery service has a characteristic called battery level.
Characteristics are values that the Central can read and/or write to.
Services are a grouping of characteristics.
The complete set of services implemented by a device is known as the device profile.

All services and characteristics have a type, and types are identified by UUIDs.
The standard describes a collection of official services and characteristics,
which are all assigned a standardized UUID.
When you invent your own services and characteristics,
you will assign your own UUIDs to them.

Characteristics also have properties, which inform clients how the given characteristic can
be accessed. Some characteristics are read-only, others may be read-write, others again may
generate indications (notifications to the client), etc.
The properties are defined as a byte-long bitmask.
For example, a characteristic that is read-only has the bitmask `0b0000010`.
A Characteristic that is read-write has the bitmask `0b0001010`.

**Security**

By default, all connections are unencrypted. Further, any Central can connect to any Peripheral.
That sounds like a security nightmare.
BLE offers functionality to improve the situation. The first is authentication (also known as bonding),
which is meant to let you know for certain which device you are connecting to.
The second is encryption, which lets the two devices encrypt the traffic between them.
Lastly, authorization can be added on top. This is a user-space concern however, and not really
specified by the BLE protocol.

## Defining our Peripheral

With all that out of the way, let's start building our device.
What we'll do is build a BLE Peripheral.
Our Peripheral will let users read and write to firmware variables,
by exposing the `Nerves.Runtime.KV` API over Bluetooth.
We'll also include the ability to reboot the device.

To do this, we must write a module which implements the `BlueHeron.GATT.Server` behaviour.
This module must define the device profile (services and characteristics),
as well as functions for reading and writing to these characteristics.
We will name the module `MyApp.FirmwareConfig.BLE`.

The profile will include two serivces: The `:gap` service, which is mandatory for all Peripherals.
The other, `:nerves_firmware_config` is our custom service.

The `:gap` service has two characteristics, both of which are mandatory: `{:gap, :device_name}`
and `{:gap, :appearance}`.
Both are read only, as can be seen from the `properties` bitmask `0b0000010`.

The `:nerves_firmware_config` has 4 properties:
One for each of the firmware variables `wifi_force`, `wifi_ssid` and `wifi_passphrase`.
`wifi_force`, `wifi_ssid` are both read-write, while `wifi_passphrase` is write-only.
The last property is for rebooting the device. This is also write-only.

```elixir
defmodule MyApp.FirmwareConfig.BLE do
  alias BlueHeron.GATT.{Characteristic, Service}

  @behaviour BlueHeron.GATT.Server

  @impl BlueHeron.GATT.Server
  def profile() do
    [
      Service.new(%{
        id: :gap,
        type: 0x1800,
        characteristics: [
          Characteristic.new(%{
            id: {:gap, :device_name},
            type: 0x2A00,
            properties: 0b0000010
          }),
          Characteristic.new(%{
            id: {:gap, :appearance},
            type: 0x2A01,
            properties: 0b0000010
          })
        ]
      }),
      Service.new(%{
        id: :nerves_firmware_config,
        type: 0x42A31ABD030C4D5CA8DF09686DD16CC0,
        characteristics: [
          Characteristic.new(%{
            id: {:nerves_firmware_config, "wifi_force"},
            type: 0x3EB9876E658C43E596D1B6ED13364BEC,
            properties: 0b0001010
          }),
          Characteristic.new(%{
            id: {:nerves_firmware_config, "wifi_ssid"},
            type: 0xC9C3323BF84048709AB34E783631F03A,
            properties: 0b0001010
          }),
          Characteristic.new(%{
            id: {:nerves_firmware_config, "wifi_passphrase"},
            type: 0xB3D6451148D54E0CB274F60CB87CD3F2,
            properties: 0b0001000
          }),
          Characteristic.new(%{
            id: {:nerves_firmware_config, :reboot},
            type: 0x177DF3FD0E94448D87719C0E22B9FDE9,
            properties: 0b0001000
          })
        ]
      })
    ]
  end

  @impl BlueHeron.GATT.Server
  def read({:gap, :device_name}) do
    serial = Nerves.Runtime.KV.get("nerves_serial_number")
    if serial == "", do: "nerves-default", else: serial
  end

  def read({:gap, :appearance}) do
    # The GAP service must have an appearance attribute,
    # whose value must be picked from this document: https://specificationrefs.bluetooth.com/assigned-values/Appearance%20Values.pdf
    # This is the standard apperance value for "IoT Gateway"
    <<0x008D::little-16>>
  end

  def read({:nerves_firmware_config, key}) when key in ["wifi_force", "wifi_ssid"] do
    Nerves.Runtime.KV.get(key)
  end

  @impl BlueHeron.GATT.Server
  def write({:nerves_firmware_config, :reboot}, _value) do
    Task.start(fn ->
      # We call `reboot` after a delay in a separate process to make sure
      # the client gets a response before we reboot.
      Process.sleep(2000)
      Nerves.Runtime.reboot()
    end)

    :ok
  end

  def write({:nerves_firmware_config, key}, value) do
    :ok = Nerves.Runtime.KV.put(key, value)
  end
end
```

## Starting our Peripheral

With the Peripheral defined, we can get to business.
First, we need to find a Bluetooth controller on our Nerves device.
Most RPi devices are equipped with a Bluetooth controller which is accessible via. UART.
Let's list the available UARTs:

```elixir
Circuits.UART.enumerate()
```

I'm running this LiveBook on a RPi 3 Model B,
and I see the available UARTs `ttyAMA0` and `ttyS0`.
I happen to know that `ttyS0` is the one that's connected to the Bluetooth controller.
This is because I have `enable_uart=1` and `dtoverlay=miniuart-bt` in the `/boot/config.txt` file.

You can put your UART in the input field below to proceed.

```elixir
uart_input = Kino.Input.text("UART device")
```

First we start a Blue Heron transport.
This will initiate the Bluetooth controller, so we can pass it to our Peripheral next.

```elixir
uart_device = Kino.Input.read(uart_input)

{:ok, context} =
  BlueHeron.transport(%BlueHeronTransportUART{
    device: uart_device,
    uart_opts: [speed: 115_200]
  })
```

Time to start the Peripheral. We pass in the context
and the name of the callback module we defined above.

```elixir
{:ok, peripheral} = BlueHeron.Peripheral.start_link(context, MyApp.FirmwareConfig.BLE)
```

The Peripheral is now running, but it's not doing anything yet.
We now need to configure advertising.
There's a few steps to this:

1. Setting the advertisement parameters.
   This configures low level details of how the controller will send advertisement packets.
   Using an empty map will give us a default config (which is fine in this case).

2. Setting the advertising data.
   This is the data that will be broadcast by the Peripheral while it's waiting
   for a Central to connect to it.
   The advertising data is a list of different types of data.
   We can freely choose which types of data we want to include in our advertising packets.
   However, the packet must be no more than 31 bytes long.

   All advertising data has the same structure: `<<length, date_type, data>>`.
   The data we include is:

   * `<<0x02, 0x01, 0b00000110>>`: This is an advertising bitmask that conveys connection information.
     In this case, the two high bits mean that our device only supports BLE (and not BR/EDR),
     and that our device is "General Connectable", meaning any device can connect to it at any time.
   * `<<0x09, 0x09, "MyApp-XY">>` This is the "Complete Local Name".
     When you scan for BLE devices, you will see this name on the list.
   * `<<0x11, 0x06, <<0x42A31ABD030C4D5CA8DF09686DD16CC0::little-128>>::binary>>`:
     An incomplete list of 128 bit service UUIDs.
     This is the UUID of our `:nerves_firmware_config` service.
     By advertising the service UUID, any Centrals nearby will know that the Peripheral implements this service,
     without requiring the Central to first connect and perform service discovery.
     This makes it easy to build an app to interact with a specific service.
     It will just have to scan for advertising packets that advertise the service UUID of the service
     that we are interested in.

3. Start advertising.

```elixir
BlueHeron.Peripheral.set_advertising_parameters(peripheral, %{})

# Advertising Data Flags: BR/EDR not supported, GeneralConnectable
# Complete Local Name
# Incomplete List of 128-bit Servive UUIDs
advertising_data =
  <<0x02, 0x01, 0b00000110>> <>
    <<0x09, 0x09, "MyApp-XY">> <>
    <<0x11, 0x06, <<0x42A31ABD030C4D5CA8DF09686DD16CC0::little-128>>::binary>>

BlueHeron.Peripheral.set_advertising_data(peripheral, advertising_data)

BlueHeron.Peripheral.start_advertising(peripheral)
```

Now, the Peripheral is advertising - and you should be able to connect to it!
I can recommend the `nRF Connect` app to try the service.
Here are a few screenshots of what it should look like:

### Scanning for devices

Note how it has picked up on the advertising data.

![scanning-for-devices](https://github.com/trarbr/nerves_livebook/raw/add-ble-peripheral-example/assets/ble/device-scan.png)

### Connected

When you click connect, the app connects to your Peripheral, and performs service discovery.
It finds the GAP service and the custom firmware config service.

![connected](https://github.com/trarbr/nerves_livebook/raw/add-ble-peripheral-example/assets/ble/device-connected.png)

### The GAP service

If you click the GAP service, you can click the down button to perform read requests -
they will hit the `read/1` functions you implemented above.

![gap-service](https://github.com/trarbr/nerves_livebook/raw/add-ble-peripheral-example/assets/ble/device-gap-services.png)

### The firmware configuration service

Try it out! Use the up arrow to send a write request. If you write to the last attribute,
the device should reboot.

![firmware-service](https://github.com/trarbr/nerves_livebook/raw/add-ble-peripheral-example/assets/ble/device-firmware-config-service.png)
