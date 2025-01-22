# .dialyzer_ignore.exs
#
# See https://github.com/jeremyjh/dialyxir#elixir-term-format
# Run "MIX_TARGET=host mix dialyzer --format short"
[
  {"lib/nerves_livebook/fwup.ex:31:17:no_return The created anonymous function has no local return."}
]
