json.event do
  json.id         event.id
  json.content    event.content
  json.created_at event.created_at

  json.url format_url("events", event.id)

  json.tags do
    json.partial! 'api/v1/tags/tag', collection: event.tags, as: :tag
  end
end
