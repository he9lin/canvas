defmodule Canvas.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def up do
    "CREATE TABLE pages(id serial PRIMARY KEY, content varchar(140), name varchar(50))"
  end

  def down do
    "DROP TABLE pages"
  end
end
