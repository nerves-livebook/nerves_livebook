defmodule NervesLivebook.WiFiMonitorTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias NervesLivebook.WiFiMonitor

  @presence_prop ["interface", "wlan0", "present"]
  @connection_prop ["interface", "wlan0", "connection"]
  @default_config %{
    type: VintageNetWiFi,
    vintage_net_wifi: %{networks: [%{ssid: "test", psk: "psk"}]}
  }

  setup do
    PropertyTable.delete(VintageNet, @presence_prop)
    PropertyTable.delete(VintageNet, @connection_prop)
    PropertyTable.delete(VintageNet, ["interface", "wlan0", "type"])
    PropertyTable.delete(VintageNet, ["interface", "wlan0", "config"])
  end

  test "stops when WiFi is LAN connected and configured" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.put(VintageNet, @connection_prop, :lan)
    start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    assert_receive :stopped
    refute_receive :start_ap
  end

  test "stops when WiFi is internet connected and configured" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.put(VintageNet, @connection_prop, :internet)
    start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    assert_receive :stopped
    refute_receive :start_ap
  end

  test "not connected and unconfigured starts AP" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.put(VintageNet, @connection_prop, :disconnected)
    start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    assert_receive :start_ap
    assert_receive :stopped
  end

  test "not connected and empty configuration starts AP" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.put(VintageNet, @connection_prop, :disconnected)
    configure_wlan(%{type: VintageNetWiFi})
    start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    assert_receive :start_ap
    assert_receive :stopped
  end

  test "not connected and configured will start AP after timeout" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.put(VintageNet, @connection_prop, :disconnected)
    configure_wlan()
    start_supervised!({WiFiMonitor, [test_fn: test_fn(), timeout: 1]})
    assert_receive :timeout
    assert_receive :stopped
    assert_receive :start_ap
  end

  test "waits until wlan0 present to run check" do
    PropertyTable.put(VintageNet, @presence_prop, false)
    PropertyTable.put(VintageNet, @connection_prop, :internet)
    configure_wlan()
    monitor = start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    assert Process.alive?(monitor)
    output = capture_log(fn -> PropertyTable.put(VintageNet, @presence_prop, true) end)
    assert_receive :stopped
    refute_receive :start_ap
    assert output =~ "wlan0 interface present"
  end

  test "waits until wlan0 connection to run check" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.delete(VintageNet, @connection_prop)
    configure_wlan()
    monitor = start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    assert Process.alive?(monitor)
    output = capture_log(fn -> PropertyTable.put(VintageNet, @connection_prop, :internet) end)
    assert_receive :stopped
    refute_receive :start_ap
    assert output =~ ~r/wlan0.*connected/
  end

  test "removed wlan0 interface keeps monitor running" do
    PropertyTable.put(VintageNet, @presence_prop, true)
    PropertyTable.put(VintageNet, @connection_prop, :disconnected)
    configure_wlan()
    monitor = start_supervised!({WiFiMonitor, [test_fn: test_fn()]})
    output = capture_log(fn -> PropertyTable.put(VintageNet, @presence_prop, false) end)
    assert_receive :continue
    refute_receive :stopped
    assert output =~ "wlan0 interface gone"
    assert Process.alive?(monitor)
  end

  defp test_fn() do
    p = self()
    fn msg -> send(p, msg) end
  end

  defp configure_wlan(config \\ @default_config) do
    # These make the wlan0 appear as an interface and seem to be empty configuration
    PropertyTable.put(VintageNet, ["interface", "wlan0", "type"], VintageNetWiFi)
    PropertyTable.put(VintageNet, ["interface", "wlan0", "config"], config)
  end
end
