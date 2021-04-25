defmodule NervesLivebook.Fwup do
  @doc """
  Upgrades the system with the specified firmware update file
  """
  @spec upgrade(String.t()) :: :ok | {:error, :error_exit}
  def upgrade(path) do
    devpath = Nerves.Runtime.KV.get("nerves_fw_devpath")

    args = [
      "--apply",
      "--no-unmount",
      "-d",
      devpath,
      "--task",
      "upgrade",
      "-i",
      path
    ]

    case System.cmd("fwup", args, into: IO.stream(:stdio, :line)) do
      {_, 0} ->
        IO.puts("Going to reboot in 5 seconds!!!")

        _ =
          spawn(fn ->
            Process.sleep(5000)
            Nerves.Runtime.reboot()
          end)

        :ok

      _ ->
        {:error, :error_exit}
    end
  end
end
