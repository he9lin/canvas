defmodule Canvas.Router do
  use Phoenix.Router

  resources "/canvases", Canvas.CanvasController
end
