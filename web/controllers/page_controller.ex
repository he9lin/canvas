defmodule Canvas.PageController do
  use Phoenix.Controller

  alias Canvas.Page
  alias Canvas.Repo
  alias Canvas.Router

  def show(conn, %{"id" => id}) do
    page = Repo.get!(Page, id)
    render conn, "show", page: page
  end

  def index(conn, _) do
    pages = Repo.all(Page)
    render conn, "index", pages: pages
  end

  def new(conn, _) do
    render conn, "new"
  end

  def create(conn, %{"page" => %{"name" => name}}) do
    page = %Page{name: name}

    case Page.validate(page) do
      [] ->
        Repo.insert(page)
        redirect conn, Router.page_path(:index)
      errors ->
        render conn, "new", page: page, errors: errors
    end
  end
end
