json.events @events do |event|
  json.id    	event.id
  json.content 	event.content
  json.created_at event.created_at

	json.tags event.tags do |tag|
		json.tag_id		tag.id
		json.name 		tag.name
	end
end