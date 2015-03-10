require 'spec_helper.rb'

feature "Looking up events", js: true do
  before do
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

      end
end
