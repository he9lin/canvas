defmodule CanvasTest.SectionTest do
  use ExUnit.Case
  alias Canvas.Page
  alias Canvas.Repo
  alias Canvas.Section

  test "has a name" do
    section = %Section{name: "section1"}
    section = Repo.insert(section)
    assert section.name == "section1"
    Repo.delete(section)
  end
end
