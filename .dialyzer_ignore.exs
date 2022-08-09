# .dialyzer_ignore.exs
#
# See https://github.com/jeremyjh/dialyxir#elixir-term-format
[
  {"lib/nerves_livebook/fwup.ex", :no_return, 31},
  {"lib/nerves_livebook/application.ex", :pattern_match, 99}
]
