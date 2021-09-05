IO.puts("""
\e[34m████▄▖    \e[36m▐███
\e[34m█▌  ▀▜█▙▄▖  \e[36m▐█
\e[34m█▌ \e[36m▐█▄▖\e[34m▝▀█▌ \e[36m▐█   \e[39mN  E  R  V  E  S
\e[34m█▌   \e[36m▝▀█▙▄▖ ▐█
\e[34m███▌    \e[36m▀▜████\e[0m
""")

# Add Toolshed helpers to the IEx session
use Toolshed

if RingLogger in Application.get_env(:logger, :backends, []) do
  IO.puts("""

  All of the Nerves projects are available in this firmware
  image. See https://github.com/fhunleth/nerves_livebook for
  more details.

  View log messages with `RingLogger.next` or `RingLogger.attach`. Toolshed
  helpers are available. Type `h Toolshed` for details.

  If connecting via ssh, type `exit` or `<enter>~.` to disconnect.
  """)
end
