defmodule Canvas.ItemController do
  use Phoenix.Controller
  require Logger

  def create(conn, %{"item" => %{"content" => content, "section_id" => section_id}}) do
    section = Repo.get!(Section, String.to_integer(section_id))
    item    = %Item{content: content, section_id: section.id}

    case Item.validate(item) do
      [] ->
        item = Repo.insert(item)
        json conn, JSON.encode!(%{item: JSONSerializer.as_json(item)})
      errors ->
        json conn, JSON.encode!(%{errors: errors |> Dict.values |> List.first})
    end
  end

  def update(conn, %{"id" => id, "item" => %{"content" => content}}) do
    item = Repo.get!(Item, String.to_integer(id))
    item = %{item | content: content}

    case Item.validate(item) do
      [] ->
        Repo.update(item)
        json conn, JSON.encode!(%{item: JSONSerializer.as_json(item)})
      errors ->
        json conn, JSON.encode!(%{errors: errors |> Dict.values |> List.first})
    end
  end

  def destroy(conn, %{"id" => id}) do
    item = Repo.get!(Item, String.to_integer(id))
    Logger.info item.id
    Repo.delete(item)
    json conn, JSON.encode!(%{})
  end
end
