defprotocol JSONSerializer do
  def as_json(thing)
end

defimpl JSONSerializer, for: Page do
  def as_json(page) do
    %{"id" => page.id, "name" => page.name}
  end
end

defimpl JSONSerializer, for: List do
  def as_json(coll) do
    Enum.map(coll, fn item -> JSONSerializer.as_json(item) end)
  end
end
