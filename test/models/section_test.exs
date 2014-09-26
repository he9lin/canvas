defmodule CanvasTest.SectionTest do
  use ExUnit.Case

  test "can create a section for a page" do
    page    = Repo.insert(%Page{name: "page 1"})
    section = Section.create(page, name: "section1")

    assert Repo.all(page.sections) == [section]

    # clean up
    Repo.delete_all(Page)
    Repo.delete_all(Section)
  end

  test "has a name" do
    section = %Section{name: "section1"}
    section = Repo.insert(section)
    assert section.name == "section1"

    Repo.delete(section)
  end

  test "validates presence of name" do
    [name: error] = Section.validate(%Section{})
    assert error == "can't be blank"
  end
end
