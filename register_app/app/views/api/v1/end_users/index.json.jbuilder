json.total_entries    @end_users.total_entries
json.current_page     @end_users.current_page
json.offset           @end_users.offset

json.users do
  json.partial! 'api/v1/end_users/end_user', collection: @end_users, as: :end_user
end
