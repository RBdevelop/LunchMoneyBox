json.array!(@orders) do |order|
  json.extract! order, :id, :description, :price, :date
  json.url order_url(order, format: :json)
end
