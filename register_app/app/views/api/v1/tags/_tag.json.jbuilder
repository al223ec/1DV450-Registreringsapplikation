json.tag do
  json.id   tag.id
  json.name tag.name

  json.url format_url("tags", tag.id)
  if !@event_tags.nil?
    json.partial! 'api/v1/events/event', collection: @event_tags, as: :event
  end
end

