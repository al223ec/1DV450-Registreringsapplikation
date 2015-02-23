# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
ApiUser.create!(
 	name: "Example User",
	email: "example@mail.com",
	password: "foobar",
	password_confirmation: "foobar",
	admin: true
)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  ApiUser.create!(
  	name: name,
    email: email,
    password: password,
    password_confirmation: password
    )
end


users = ApiUser.order(:created_at).take(6)
50.times do
  name = Faker::Name.name
  users.each { |user| user.applications.create!(name: name) }
end

app = Application.first

EndUser.create!(
 	name: "End User",
	email: "end_user@mail.com",
	password: "foobar",
	password_confirmation: "foobar",
  application_id: app.id
)

applications = Application.order(:created_at).take(3); 

i = 0
20.times do |n|
  applications.each { |app| 
    name  = Faker::Name.name
    email = "example-#{i+=1}@enduser.org"
    password = "password"
    app.end_users.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
    )}
end

endUsers = EndUser.order(:created_at).take(6)
Position.create!(
	lat: 59.422728,
	lng: 17.973633
)
position = Position.order(:created_at).first

20.times do |n|
	endUsers.each { |user| user.events.create!(position_id: position.id, application_id: user.application_id) }
end
