defmodule Page do
  use Ecto.Model

  validate page, name: present()

  schema "pages" do
    field :name
    has_many :sections, Section
  end

  @default_section_names ["Problem", "Existing Alternatives", "Solution",
    "Key Metrics", "Unique Value Proposition", "High-level Concept",
    "Unfair Advantage", "Channels", "Customer Segments", "Early Adopter",
    "Cost Structure", "Revenue Streams"]
  def create([name: name]) do
    page = Repo.insert(%Page{name: name})
    @default_section_names
      |> Enum.each(fn n -> Section.create(page, name: n) end)
    page
  end
end
