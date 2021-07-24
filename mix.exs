defmodule NervesLivebook.MixProject do
  use Mix.Project

  @app :nerves_livebook
  @version "0.2.15"
  @all_targets [
    :rpi,
    :rpi0,
    :rpi2,
    :rpi3,
    :rpi3a,
    :rpi4,
    :bbb,
    :osd32mp1,
    :x86_64,
    :npi_imx6ull
  ]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.12",
      archives: [nerves_bootstrap: "~> 1.10"],
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host]
    ]
  end

  def application do
    [
      mod: {NervesLivebook.Application, []},
      extra_applications: [:logger, :runtime_tools, :inets]
    ]
  end

  defp deps do
    [
      # Dependencies for host and target
      {:nerves, "~> 1.7.4", runtime: false},
      {:shoehorn, "~> 0.7.0"},
      {:ring_logger, "~> 0.8.1"},
      {:toolshed, "~> 0.2.13"},
      {:jason, "~> 1.2"},
      {:livebook, "~> 0.2.0", only: [:dev, :prod]},
      {:nerves_runtime, "~> 0.11.3"},
      {:nerves_pack, "~> 0.4.0"},

      # Extra Livebook dependencies since Mix.install doesn't work yet
      {:vega_lite, "~> 0.1.0"},
      {:kino, "~> 0.2.1"},

      # Dependencies for all targets except :host
      {:circuits_uart, "~> 1.3", targets: @all_targets},
      {:circuits_gpio, "~> 0.4", targets: @all_targets},
      {:circuits_i2c, "~> 0.3", targets: @all_targets},
      {:circuits_spi, "~> 0.1", targets: @all_targets},
      {:nerves_key, "~> 0.5.5", targets: @all_targets},
      {:pigpiox, "~>0.1", targets: [:rpi, :rpi0, :rpi2, :rpi3, :rpi3a, :rpi4]},
      {:power_control, github: "cjfreeze/power_control", targets: @all_targets},
      {:ramoops_logger, "~> 0.1", targets: @all_targets},
      {:bmp280, "~> 0.2", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.15", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.15", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.15", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.15", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.15", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.15", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.10", runtime: false, targets: :bbb},
      {:nerves_system_osd32mp1, "~> 0.6", runtime: false, targets: :osd32mp1},
      {:nerves_system_x86_64, "~> 1.15", runtime: false, targets: :x86_64},
      {:nerves_system_npi_imx6ull, "~> 0.2", runtime: false, targets: :npi_imx6ull}
    ]
  end

  def release do
    [
      overwrite: true,
      # Erlang distribution is not started automatically.
      # See https://hexdocs.pm/nerves_pack/readme.html#erlang-distribution
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: [keep: ["Docs"]]
    ]
  end
end
