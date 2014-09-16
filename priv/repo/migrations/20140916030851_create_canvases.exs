defmodule Canvas.Repo.Migrations.CreateCanvases do
  use Ecto.Migration

  def up do
    "CREATE TABLE canvases(id serial primary key, content varchar(140), name varchar(50))"
  end

  def down do
    "DROP TABLE canvases"
  end
end
