json.array!(@messages) do |message|
  json.extract! message, :id, :to, :content, :time
  json.url message_url(message, format: :json)
end
