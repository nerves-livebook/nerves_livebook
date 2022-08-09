defmodule NervesLivebook.WiFiMonitor do
  @moduledoc """
  Monitor WiFi on startup to determine if AP mode needs to be enabled

  This is mostly for devices that must have a WiFi connection in order to interact and
  make firmware changes. It checks:

  * If any WiFi interface available to configure
  * If any WiFi interface is configured
  * If any WiFi interface is connected

  If WiFi interface is configured, but not connected, then this monitor will watch
  for a successful connection message for 3 minutes. If no connection is established
  after that time, then it will set the WiFi interface to AP mode to allow the user
  to connect directly to the device

  If no WiFi interface is present, then this will run until presence is detected.
  """
  use GenServer, restart: :transient

  require Logger

  @presence_prop ["interface", "wlan0", "present"]
  @connection_prop ["interface", "wlan0", "connection"]
  @connected_status [:lan, :internet]
  @default_timeout 3 * 60 * 1000

  @spec start_link(Keyword.t()) :: GenServer.on_start()
  def start_link(opts \\ []), do: GenServer.start_link(__MODULE__, opts, name: __MODULE__)

  @impl GenServer
  def init(opts) do
    # These are mostly used for testing
    state = %{
      timeout:
        opts[:timeout] ||
          Application.get_env(:nerves_livebook, :wifi_monitor_timeout, @default_timeout),
      test_fn: opts[:test_fn]
    }

    VintageNet.subscribe(@presence_prop)
    VintageNet.subscribe(@connection_prop)

    if VintageNet.get(@presence_prop) do
      {:ok, state, {:continue, :check_connection}}
    else
      {:ok, state}
    end
  end

  @impl GenServer
  def handle_continue(:check_connection, state) do
    cond do
      connected?() ->
        stop(state)

      unconfigured?() ->
        start_ap(state)
        stop(state)

      true ->
        {:noreply, state, state.timeout}
    end
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    _ = if state.test_fn, do: state.test_fn.(:timeout)
    _ = unless connected?(), do: start_ap(state)

    stop(state)
  end

  def handle_info({VintageNet, @presence_prop, _old, true, _meta}, state) do
    # wlan0 now present so run our checks again
    Logger.info("[WiFiMonitor] wlan0 interface present")
    {:noreply, state, {:continue, :check_connection}}
  end

  def handle_info({VintageNet, @presence_prop, true, _new, _meta}, state) do
    # wlan0 is gone for some reason. Matching here stops any GenServer timer so
    # we can continue waiting for wlan0 to come back
    Logger.warn("[WiFiMonitor] wlan0 interface gone")
    _ = if state.test_fn, do: state.test_fn.(:continue)
    {:noreply, state}
  end

  def handle_info({VintageNet, @connection_prop, _old, new, _meta}, state)
      when new in @connected_status do
    Logger.info("[WiFiMonitor] wlan0 #{IO.ANSI.green()}connected!#{IO.ANSI.default_color()}")
    stop(state)
  end

  def handle_info({VintageNet, @connection_prop, _old, new, _meta}, state) do
    Logger.warn("[WiFiMonitor] wlan0 connection: #{new}")
    {:noreply, state, {:continue, :check_connection}}
  end

  defp unconfigured?() do
    "wlan0" not in VintageNet.configured_interfaces() or
      VintageNet.get_configuration("wlan0") == %{type: VintageNetWiFi}
  end

  defp connected?() do
    VintageNet.get(@connection_prop) in @connected_status
  end

  defp stop(state) do
    _ = if state.test_fn, do: state.test_fn.(:stopped)
    {:stop, :normal, state}
  end

  if Mix.target() == :host do
    defp start_ap(%{test_fn: test_fn}) when is_function(test_fn), do: test_fn.(:start_ap)
    defp start_ap(_state), do: :ok
  else
    defp start_ap(_state) do
      # TODO: Change some LED here to indicate AP mode?
      {:ok, hostname} = :inet.gethostname()

      {:ok, config} = VintageNetWiFi.Cookbook.open_access_point(to_string(hostname))

      VintageNet.configure("wlan0", config, persist: false)
    end
  end
end
