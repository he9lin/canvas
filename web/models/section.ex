defmodule Canvas.Section do
  use Ecto.Model

  schema "sections" do
    field :name
    belongs_to :page, Canvas.Post
  end
end
