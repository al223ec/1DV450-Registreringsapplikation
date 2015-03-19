  json.id         event.id
  json.content    event.content
  json.created_at event.created_at
  json.url format_url("events", event.id)

  json.end_user do
    json.partial! 'api/v1/end_users/end_user', end_user: event.end_user
  end

  json.position  do
    json.id  event.position.id
    json.address event.position.address
    json.url format_url("positions", event.position.id)
  end

  json.tags do
    json.partial! 'api/v1/tags/tag', collection: event.tags, as: :tag
  end
