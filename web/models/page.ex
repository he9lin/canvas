defmodule Canvas.Page do
  use Ecto.Model
  alias Canvas.Section

  validate page, name: present()

  schema "pages" do
    field :name
    has_many :sections, Section
  end
end
