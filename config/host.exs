import Config

# Configure Nerves runtime dependencies for the host
config :nerves_runtime, Nerves.Runtime.KV.Mock, %{"nerves_fw_devpath" => "/dev/will_not_work"}

# Overrides for unit tests:
#
# * udhcpc_handler: capture whatever happens with udhcpc
# * udhcpd_handler: capture whatever happens with udhcpd
# * interface_renamer: capture interfaces that get renamed
# * resolvconf: don't update the real resolv.conf
# * path: limit search for tools to our test harness
# * persistence_dir: use the current directory
# * power_managers: register a manager for test0 so that tests
#      that need to validate power management calls can use it.
config :vintage_net,
  udhcpc_handler: VintageNetTest.CapturingUdhcpcHandler,
  udhcpd_handler: VintageNetTest.CapturingUdhcpdHandler,
  interface_renamer: VintageNetTest.CapturingInterfaceRenamer,
  resolvconf: "/dev/null",
  path: "#{File.cwd!()}/test/fixtures/root/bin",
  persistence_dir: "./test_tmp/persistence"
