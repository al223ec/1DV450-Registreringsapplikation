# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# User.create!(
# 	name: "Example User",
#	email: "example@mail.com",
#	password: "foobar",
#	password_confirmation: "foobar",
#	admin: true
#)

#99.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(
#  	name: name,
#    email: email,
#    password: password,
#    password_confirmation: password
#    )
#end

# users = User.order(:created_at).take(6)
# 50.times do
#  name = Faker::Name.name
#  users.each { |user| user.applications.create!(name: name) }
# end
Position.create!(
	lat: 59.422728,
	lng: 17.973633
)

position = Position.order(:created_at).first

20.times do |n|
	Event.create!(
		position_id: position.id
	)
end