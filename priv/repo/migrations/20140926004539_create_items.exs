defmodule Canvas.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def up do
    "CREATE TABLE items(id serial PRIMARY KEY, section_id integer, content varchar(140))"
  end

  def down do
    "DROP TABLE items"
  end
end
