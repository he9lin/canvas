defprotocol JSONSerializer do
  def as_json(thing)
end

defimpl JSONSerializer, for: Page do
  def as_json(page) do
    %{id: page.id, name: page.name} |> Dict.put_new(:sections, JSONSerializer.as_json(Repo.all(page.sections)))
  end
end

defimpl JSONSerializer, for: List do
  def as_json(coll) do
    Enum.map(coll, fn item -> JSONSerializer.as_json(item) end)
  end
end

defimpl JSONSerializer, for: Section do
  def as_json(section) do
    %{id: section.id, name: section.name} |> Dict.put_new(:items, JSONSerializer.as_json(Repo.all(section.items)))
  end
end

defimpl JSONSerializer, for: Item do
  def as_json(item) do
    %{id: item.id, content: item.content, section_id: item.section_id}
  end
end
