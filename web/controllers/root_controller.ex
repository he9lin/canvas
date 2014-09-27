defmodule Canvas.RootController do
  use Phoenix.Controller

  def index(conn, _) do
    render conn, "index"
  end
end
