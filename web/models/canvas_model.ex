defmodule Canvas.CanvasModel do
  use Ecto.Model

  validate canvas, name: present()

  schema "canvases" do
    field :name
  end
end
