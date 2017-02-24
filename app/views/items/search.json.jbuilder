json.array!(@items) do |item|
    json.extract! item, :id, :title, :slug, :media
end