json.array!(@items) do |item|
    item.extract! item, :id, :title, :media
end