defmodule CanvasTest.Page do
  use ExUnit.Case
  alias Canvas.Page
  alias Canvas.Repo

  test "can create many sections" do
    page = %Page{name: "page 1"}
    Repo.insert(page)
    [page | _] = Repo.all(Page)
    assert Enum.count(Repo.all(page.sections)) == 0
    Repo.delete(page)
  end
end
