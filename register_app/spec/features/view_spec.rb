require 'spec_helper.rb'

feature "Viewing a event", js: true do
  before do
    # fails
  end

  scenario "view one event" do
    visit '/spa'
    fill_in "keywords", with: "aspe"
    click_on "Search"

    click_on "Est asperiores exercitationem voluptate minima officia et et reiciendis."

    expect(page).to have_content("Est asperiores exercitationem voluptate minima officia et et reiciendis.s")

    click_on "Back"

    expect(page).to     have_content("Est asperiores exercitationem voluptate minima officia et et reiciendis")
  end
end
