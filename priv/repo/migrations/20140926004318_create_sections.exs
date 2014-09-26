defmodule Canvas.Repo.Migrations.CreateSections do
  use Ecto.Migration

  def up do
    "CREATE TABLE sections(id serial PRIMARY KEY, page_id integer, name varchar(50))"
  end

  def down do
    "DROP TABLE sections"
  end
end
