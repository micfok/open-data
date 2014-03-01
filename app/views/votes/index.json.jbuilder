json.array!(@votes) do |vote|
  json.extract! vote, :id, :user_id, :expenditure_id
  json.url vote_url(vote, format: :json)
end
