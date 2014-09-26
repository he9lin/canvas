defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  @database_url Application.get_env(:repo, :database_url)

  def conf do
    parse_url @database_url
  end

  def priv do
    app_dir(:canvas, "priv/repo")
  end
end
