defmodule Canvas.CanvasController do
  use Phoenix.Controller

  def show(conn, _) do
    render conn, "show", canvas: "Canvas"
  end
end
