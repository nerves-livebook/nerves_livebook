# Add Toolshed helpers to the IEx session
use Toolshed

if RingLogger in Application.get_env(:logger, :backends, []) do
  IO.puts([
    IO.ANSI.color(5),
    """

                    ;kX'
                  ,0XXXl
                 xNXNNXX.
               'KNNXXXXX0.
              ;XNNNNNNNNN0.
             ;XNNNNNNNNNNNX:
            .XNNNXXXXXXXXXXXO.
            kNNNXNNNNXXNXXNNXNo
           .NNNXNNNNNXXNNXNNXXXO
           cXXXNNNNNNXXNNNNNNNNNd
           lNNNNNNNNNXXNXXXNNNNNK
           'NNXNXNXXXXXXXXXNNNNNk
            oNXNXXXXXNXXXNNNNXXX.
             :KXXXXXXNXXXNNNNXk.
               ;xXNXXXXNXXX0o.
                  .',::;,.

    """,
    IO.ANSI.reset(),
    """
          Nerves Livebook

    All of the Nerves projects are available in this firmware
    image. See https://github.com/elixir-circuits/nerves_livebook for
    more details.

    View log messages with `RingLogger.next` or `RingLogger.attach`. Toolshed
    helpers are available. Type `h Toolshed` for details.

    If connecting via ssh, type `exit` or `<enter>~.` to disconnect.
    """
  ])
end
