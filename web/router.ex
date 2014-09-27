defmodule Canvas.Router do
  use Phoenix.Router

  get "/", Canvas.RootController, :index

  resources "/pages", Canvas.PageController
  resources "/sections", Canvas.SectionController do
    resources "/items", Canvas.ItemController
  end
end
