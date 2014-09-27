defmodule Canvas.Router do
  use Phoenix.Router

  get "/", Canvas.RootController, :index

  resources "/pages", Canvas.PageController
  resources "/sections", Canvas.SectionController
  resources "/items", Canvas.ItemController
end
