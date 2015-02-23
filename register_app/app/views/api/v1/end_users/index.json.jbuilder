json.end_users @end_users do |user|
  json.id   user.id
  json.name user.name
  json.email user.email

  json.created_at user.created_at
  json.application_id user.application ? user.application.id : nil
end