defmodule Canvas.CanvasController do
  use Phoenix.Controller
  alias Canvas.CanvasModel
  alias Canvas.Repo
  alias Canvas.Router

  def show(conn, %{"id" => id}) do
    canvas = Repo.get!(CanvasModel, id)
    render conn, "show", canvas: canvas
  end

  def index(conn, _) do
    canvases = Repo.all(CanvasModel)
    render conn, "index", canvases: canvases
  end

  def new(conn, _) do
    render conn, "new"
  end

  def create(conn, %{"canvas" => %{"name" => name}}) do
    canvas = %CanvasModel{name: name}

    case CanvasModel.validate(canvas) do
      [] ->
        canvas = Repo.insert(canvas)
        redirect conn, Router.canvas_path(:index)
      errors ->
        render conn, "new", canvas: canvas, errors: errors
    end
  end
end
