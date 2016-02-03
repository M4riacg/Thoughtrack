json.array!(@priorities) do |priority|
  json.extract! priority, :id, :name, :level, :color
  json.url priority_url(priority, format: :json)
end
