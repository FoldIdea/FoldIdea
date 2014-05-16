json.array!(@base_units) do |base_unit|
  json.extract! base_unit, :id, :name, :base_width, :base_length
  json.url base_unit_url(base_unit, format: :json)
end
