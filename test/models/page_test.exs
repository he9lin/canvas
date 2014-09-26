defmodule CanvasTest.Page do
  use ExUnit.Case
  require Logger

  test "can create many sections" do
    page     = Repo.insert(%Page{name: "page 1"})
    sections = page.sections
    assert Enum.count(Repo.all(sections)) == 0

    Repo.insert(struct(sections, []))
    assert Enum.count(Repo.all(page.sections)) == 1

    # clean up
    Repo.delete_all(Page)
    Repo.delete_all(Section)
  end
end
