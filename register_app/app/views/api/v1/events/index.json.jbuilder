json.total_entries    @events.total_entries
json.current_page     @events.current_page
json.offset           @events.offset

json.events do
  json.partial! 'api/v1/events/event', collection: @events, as: :event
end
