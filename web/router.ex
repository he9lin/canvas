defmodule Canvas.Router do
  use Phoenix.Router

  resources "/pages", Canvas.PageController
end
