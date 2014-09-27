defmodule Section do
  use Ecto.Model

  validate section,
    name: present(),
    page_id: present()

  schema "sections" do
    field      :name
    belongs_to :page, Post
    has_many   :items, Item
  end

  def create(page, params) do
    Repo.insert struct(page.sections, params)
  end
end
