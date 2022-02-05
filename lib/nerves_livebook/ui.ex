defmodule NervesLivebook.UI do
  @moduledoc """
  Provide a simple UI using the device's built-in LEDs

  Livebook, of course, is the main UI. This module handles one LED for now
  since every supported device has one.
  """
  use GenServer
  alias NervesLivebook.PatternLED

  require Logger

  @typedoc false
  @type option() :: {:led, String.t()}

  @not_connected_pattern PatternLED.blink(4)
  @connected_pattern PatternLED.on()

  @doc """
  Start the UI GenServer

  Options:

  * `:led` - the name of the LED to use (like "led0" for the Raspberry Pis)
  """
  @spec start_link([option]) :: GenServer.on_start()
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(opts) do
    with {:ok, led} <- Keyword.fetch(opts, :led),
         true <- is_binary(led),
         :ok <- PatternLED.initialize_led(led) do
      VintageNet.subscribe(["connection"])
      update_led(led, VintageNet.get(["connection"]))

      {:ok, led}
    else
      _ ->
        # No LED configured, so just carry on and don't do anything.
        Logger.info("NervesLivebook: No LED configured or error so not showing device status")
        :ignore
    end
  end

  @impl GenServer
  def handle_info({VintageNet, ["connection"], _old, value, _meta}, led) do
    update_led(led, value)
    {:noreply, led}
  end

  defp update_led(led, network_connection) do
    pattern = network_connection_to_led(network_connection)

    case PatternLED.set_led_pattern(led, pattern) do
      :ok ->
        :ok

      {:error, reason} ->
        Logger.info("NervesLivebook failed to set LED '#{led}': #{inspect(reason)}")
    end
  end

  defp network_connection_to_led(:lan), do: @connected_pattern
  defp network_connection_to_led(:internet), do: @connected_pattern
  defp network_connection_to_led(_other), do: @not_connected_pattern
end
