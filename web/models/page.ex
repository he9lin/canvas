defmodule Page do
  use Ecto.Model

  validate page, name: present()

  schema "pages" do
    field    :name
    has_many :sections, Section
  end
end
