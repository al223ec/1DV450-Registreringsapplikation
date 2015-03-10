json.id         end_user.id
json.name       end_user.name
json.email      end_user.email
json.created_at end_user.created_at

json.url format_url("end_users", end_user.id)

