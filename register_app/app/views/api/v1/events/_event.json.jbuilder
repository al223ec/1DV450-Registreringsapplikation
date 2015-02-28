json.event do
  json.id         event.id
  json.content    event.content
  json.created_at event.created_at

  json.url format_url(@base_url, event.id)

  json.tags do
    @nested = event.id.to_s << "/tags"
    json.partial! 'api/v1/tags/tag', collection: event.tags, as: :tag
  end
end
