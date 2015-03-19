require 'spec_helper.rb'

feature "Looking up events", js: true do
  before do
    populate_test_data
    # File.open("#{::Rails.root}/app/assets/javascripts/my_config.json", 'w') do |file|
    #   file.syswrite(@app.key)
    # end

    # Måste nog köra mot seed datan eller något
    # är nog också beroend på api nyckeln, svår testat
  end

  scenario "finding events" do
    visit '/spa'
    fill_in "keywords", with: "asper"
    click_on "Search"

    sleep 1.seconds

    expect(page).to have_content("asperiores")
  end

    private
      def populate_test_data
        api_user = ApiUser.create!(
          name: "Example User",
          email: "example_rspec@mail.com",
          password: "foobar",
          password_confirmation: "foobar",
          admin: false
        )

        @app = Application.create!(
          name: "Miss Schuyler Padberg",
          api_user: api_user,
          );

        @end_user = EndUser.create!(
          name: "End User",
          email: "end_user_rspec@mail.com",
          password: "foobar",
          password_confirmation: "foobar",
          application_id: @app.id
        )

        position = Position.create!(  lat: 59.08793, lng: 17.96473)
        @event = Event.create!( content: 'Baked Potato w/ Cheese', position: position, end_user: @end_user, application: @app)
        Event.create!(content: 'Garlic Mashed Potatoes', position: position, end_user: @end_user, application: @app)
        Event.create!(content: 'Potatoes Au Gratin', position: position, end_user: @end_user, application: @app)
        Event.create!(content: 'Baked Brussel Sprouts', position: position, end_user: @end_user, application: @app)
      end
end
