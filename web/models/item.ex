defmodule Item do
  use Ecto.Model

  validate item,
    content: present(),
    section_id: present()

  schema "items" do
    field :content
    belongs_to :section, Section
  end
end
