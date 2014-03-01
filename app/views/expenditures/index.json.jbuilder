json.array!(@expenditures) do |expenditure|
  json.extract! expenditure, :id, :title, :amount
  json.url expenditure_url(expenditure, format: :json)
end
