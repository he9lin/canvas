defmodule Section do
  use Ecto.Model

  validate section, name: present()

  schema "sections" do
    field      :name
    belongs_to :page, Post
  end

  def create(page, params) do
    Repo.insert struct(page.sections, params)
  end
end
