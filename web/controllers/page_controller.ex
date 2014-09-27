defmodule Canvas.PageController do
  use Phoenix.Controller
  require Logger

  def show(conn, %{"id" => id}) do
    page      = Repo.get!(Page, String.to_integer(id))
    sections  = Repo.all(page.sections)
    page_json = JSONSerializer.as_json(page) |> Dict.put_new(:sections, JSONSerializer.as_json(sections))

    json conn, JSON.encode!(%{page: page_json})
  end

  def index(conn, _) do
    pages = Repo.all(Page)
    json conn, JSON.encode!(%{pages: JSONSerializer.as_json(pages)})
  end

  def create(conn, %{"page" => %{"name" => name}}) do
    page = %Page{name: name}

    case Page.validate(page) do
      [] ->
        page = Page.create(name: name)
        json conn, JSON.encode!(%{page: JSONSerializer.as_json(page)})
      errors ->
        json conn, JSON.encode!(%{errors: errors |> Dict.values |> List.first})
    end
  end

  def update(conn, %{"id" => id, "page" => %{"name" => name}}) do
    page = Repo.get!(Page, String.to_integer(id))
    page = %{page | name: name}

    case Page.validate(page) do
      [] ->
        Repo.update(page)
        json conn, JSON.encode!(%{page: JSONSerializer.as_json(page)})
      errors ->
        json conn, JSON.encode!(%{errors: errors |> Dict.values |> List.first})
    end
  end
end
