json.tag do
  json.id   tag.id
  json.name tag.name

  json.url format_url(@base_url, tag.id, @nested)
end

