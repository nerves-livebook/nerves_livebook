defmodule NervesLivebook.RedirectNervesLocal do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  @impl Plug
  def init(opts) do
    opts
  end

  @impl Plug
  def call(conn, _opts) do
    # Redirect nerves.local to the preferred hostname advertised over mDNS
    if conn.host == "nerves.local" do
      {:ok, hostname} = :inet.gethostname()

      url =
        conn
        |> request_url()
        |> URI.parse()
        |> Map.put(:host, "#{hostname}.local")
        |> URI.to_string()

      html = Plug.HTML.html_escape(url)
      body = "<html><body>You are being <a href=\"#{html}\">redirected</a>.</body></html>"

      conn
      |> put_resp_header("location", url)
      |> send_resp(conn.status || 302, body)
      |> halt()
    else
      conn
    end
  end
end
