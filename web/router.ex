defmodule Canvas.Router do
  use Phoenix.Router

  get "/canvas/:id", Canvas.CanvasController, :show, as: :canvas
end
