defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://postgres:postgres@localhost/canvas_development"
  end

  def priv do
    app_dir(:canvas, "priv/repo")
  end
end
