defmodule NervesLivebook.UI do
  @moduledoc """
  Provide a simple UI using the device's built-in LEDs

  Livebook, of course, is the main UI. This module handles one LED for now
  since every supported device has one.
  """
  use GenServer
  alias Delux.Effects

  require Logger

  @doc """
  Start the UI GenServer

  Options:
    * None
  """
  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_opts) do
    VintageNet.subscribe(["connection"])
    value = VintageNet.get(["connection"])

    Delux.render(NervesLivebook.Delux, led_program(value))
    {:ok, :no_state}
  end

  @impl GenServer
  def handle_info({VintageNet, ["connection"], _old, value, _meta}, state) do
    Delux.render(NervesLivebook.Delux, led_program(value))
    {:noreply, state}
  end

  def handle_info(_, state), do: {:noreply, state}

  defp led_program(:internet), do: Effects.on(:cyan)
  defp led_program(:lan), do: Effects.on(:cyan)
  defp led_program(_disconnected), do: Effects.blink(:cyan, 4)
end
