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

  test "validates presence of page_id" do
    errors = Section.validate(%Section{})
    assert errors[:page_id] == "can't be blank"
  end

  test "validates presence of name" do
    errors = Section.validate(%Section{})
    assert errors[:name] == "can't be blank"
  end
end
