json.event do
  json.id    	@event.id
  json.content 	@event.content
	json.tags @event.tags do |tag|
		json.tag_id		tag.id
		json.name 		tag.name
	end
end
