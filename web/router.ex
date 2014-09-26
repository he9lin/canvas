defmodule Canvas.Router do
  use Phoenix.Router

  resources "/pages", Canvas.PageController do
    resources "/sections", Canvas.SectionController
  end
end
