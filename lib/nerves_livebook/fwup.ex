defmodule NervesLivebook.Fwup do
  @doc """
  Upgrades the system with the specified firmware update file
  """
  @spec upgrade(String.t(), [String.t()]) :: :ok | {:error, :error_exit}
  def upgrade(path, extra_arguments \\ []) do
    devpath = Nerves.Runtime.KV.get("nerves_fw_devpath")

    args =
      [
        "--apply",
        "--no-unmount",
        "-d",
        devpath,
        "--task",
        "upgrade",
        "-i",
        path
      ] ++ extra_arguments

    case System.cmd("fwup", args, into: IO.stream(:stdio, :line)) do
      {_, 0} ->
        IO.write("Going to reboot in 5")

        for i <- 4..1 do
          Process.sleep(1000)
          IO.write(", #{i}")
        end

        _ =
          spawn(fn ->
            Process.sleep(1000)
            Nerves.Runtime.reboot()
          end)

        :ok

      _ ->
        {:error, :error_exit}
    end
  end
end
