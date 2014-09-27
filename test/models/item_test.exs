defmodule CanvasTest.Item do
  use ExUnit.Case

  test "validates presence of content" do
    errors = Item.validate(%Item{})
    assert errors[:content] == "can't be blank"
  end

  test "validates presence of section_id" do
    errors = Item.validate(%Item{})
    assert errors[:section_id] == "can't be blank"
  end

  test "creates with a section" do
    page    = Repo.insert(%Page{name: "page 1"})
    section = Section.create(page, name: "section1")
    item    = %Item{content: "item", section_id: section.id}
    item    = Repo.insert(item)

    assert Repo.all(section.items) == [item]

    # clean up
    Repo.delete_all(Page)
    Repo.delete_all(Section)
    Repo.delete_all(Item)
  end
end
