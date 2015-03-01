json.position do
  json.id     position.id
  json.lat    position.lat
  json.lng    position.lng
  json.address  position.address
  json.created_at position.created_at

  json.url format_url("positions", position.id)
  if @show_events
    json.events do
      json.partial! 'api/v1/events/event', collection: position.events, as: :event
    end
  end
end
