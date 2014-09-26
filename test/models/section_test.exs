defmodule CanvasTest.SectionTest do
  use ExUnit.Case

  test "has a name" do
    section = %Section{name: "section1"}
    section = Repo.insert(section)
    assert section.name == "section1"
    Repo.delete(section)
  end
end
