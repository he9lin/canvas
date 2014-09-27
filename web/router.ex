defmodule Canvas.Router do
  use Phoenix.Router

  resources "/pages", Canvas.PageController
  resources "/sections", Canvas.SectionController do
    resources "/items", Canvas.ItemController
  end
end
