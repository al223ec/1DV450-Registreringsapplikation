require 'spec_helper.rb'

feature "Looking up events", js: true do
  before do
      api_user = ApiUser.create!(
        name: "Example User",
        email: "example@mail.com",
        password: "foobar",
        password_confirmation: "foobar",
        admin: false
      )

      app = Application.create!(
        name: "Miss Schuyler Padberg",
        api_user: api_user,
        );

      end_user = EndUser.create!(
        name: "End User",
        email: "end_user@mail.com",
        password: "foobar",
        password_confirmation: "foobar",
        application_id: app.id
      )
      position = Position.create!(  lat: 59.08793, lng: 17.96473)

      Event.create!(content: 'Baked Potato w/ Cheese', position: position, end_user: end_user, application: app)
      Event.create!(content: 'Garlic Mashed Potatoes', position: position, end_user: end_user, application: app)
      Event.create!(content: 'Potatoes Au Gratin', position: position, end_user: end_user, application: app)
      Event.create!(content: 'Baked Brussel Sprouts', position: position, end_user: end_user, application: app)

  end

scenario "finding events" do
    visit '/spa'
    fill_in "keywords", with: "Asperiores"
    click_on "Search"

    sleep 1.seconds

    expect(page).to have_content("asperiores")
  end
end
