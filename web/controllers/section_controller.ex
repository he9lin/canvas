defmodule Canvas.SectionController do
  use Phoenix.Controller
  require Logger

  def update(conn, %{"id" => id, "section" => %{"name" => name}}) do
    section = Repo.get!(Section, String.to_integer(id))
    section = %{section | name: name}

    case section.validate(section) do
      [] ->
        Repo.update(section)
        json conn, JSON.encode!(%{section: JSONSerializer.as_json(section)})
      errors ->
        json conn, JSON.encode!(%{errors: errors |> Dict.values |> List.first})
    end
  end
end
