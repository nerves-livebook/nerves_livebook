defmodule NervesLivebook.PatternLED do
  @moduledoc """
  Functions for sending patterns to LEDs

  This module uses the Linux's sysclass LED pattern trigger to control LEDs.
  With it, you can make LEDs do tons of things without spending any time in the
  Erlang VM. The code in this module constructs patterns to blink the LED in
  various ways. Pattern strings get sent to the kernel by calling
  `PatternLED.set_led_pattern/2`.

  To use the pattern trigger, it is important to have the following Linux
  kernel options enabled:

  ```text
  CONFIG_LEDS_CLASS=y
  CONFIG_LEDS_TRIGGER_PATTERN=y
  ```

  Additionally, the LEDs need to be defined in the device tree file so that
  they show up in the `"/sys/class/leds"` directory.

  This module has functions to generate patterns. They don't need to be used.
  Patterns are strings of the form `<on/off> <milliseconds>...`. The `on/off`
  field should be set to `0` or `1`. The `milliseconds` field is the transition
  time between the current state and the next one. Linux will interpolate the
  LED value in over the duration. If the LED had on/off values of `0` and
  `255`, this would be interesting. However, most LED drivers only support `0`
  and `1` and to avoid any fade transitions, the pattern generators in this
  module set up `0` duration fades.
  """

  @typedoc false
  @type blink_option() :: {:duty_cycle, number()} | {:off_first, boolean()}

  @doc """
  Initialize an LED so that patterns can be written to it

  This should be called any time the code isn't sure what state the LED is in.
  It will force it to use the "pattern" trigger. For this to succeed, the
  specified LED must exist in `/sys/class/leds` and the Linux kernel must have
  pattern triggers enabled. Pattern triggers are enabled in Nerves systems, but
  they're not as commonly enabled elsewhere.
  """
  @spec initialize_led(String.t()) :: :ok | {:error, atom()}
  def initialize_led(led) when is_binary(led) do
    File.write(["/sys/class/leds/", led, "/trigger"], "pattern")
  end

  @doc """
  Set the LED pattern

  The LED pattern can be any of the various strings returned by other functions
  in this module.
  """
  @spec set_led_pattern(String.t(), String.t()) :: :ok | {:error, atom()}
  def set_led_pattern(led, pattern) when is_binary(led) do
    File.write(["/sys/class/leds/", led, "/pattern"], pattern)
  end

  @doc """
  Turn the LED on
  """
  @spec on() :: String.t()
  def on() do
    "1 3600000 1 3600000"
  end

  @doc """
  Turn the LED off
  """
  @spec off() :: String.t()
  def off() do
    "0 3600000 0 3600000"
  end

  @doc """
  Return a simple blinking pattern

  Options:

  * `:duty_cycle` - a number between 0 and 1.0 that's the fraction of time the
    LED is on (default is 0.5)
  * `:off_first` - set to `true` to start in the "off" state, then switch to "on"
  """
  @spec blink(number(), [blink_option()]) :: String.t()
  def blink(frequency, opts \\ []) when frequency > 0 do
    duty_cycle = bound(0, opts[:duty_cycle] || 0.5, 1)
    off_first = opts[:off_first]

    period_ms = round(1000 / frequency)
    on_time = round(period_ms * duty_cycle)
    off_time = period_ms - on_time

    on_pattern = "1 #{on_time} 1 0"
    off_pattern = "0 #{off_time} 0 0"

    if off_first do
      off_pattern <> " " <> on_pattern
    else
      on_pattern <> " " <> off_pattern
    end
  end

  defp bound(lower, value, upper) do
    value
    |> max(lower)
    |> min(upper)
  end
end
