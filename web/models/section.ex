defmodule Section do
  use Ecto.Model

  schema "sections" do
    field :name
    belongs_to :page, Post
  end
end
