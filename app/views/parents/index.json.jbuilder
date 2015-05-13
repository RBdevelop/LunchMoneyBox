json.array!(@parents) do |parent|
  json.extract! parent, :id, :first_name, :last_name
  json.url parent_url(parent, format: :json)
end
