require 'rails_helper'

RSpec.feature "Logged in user can create links" do
  include SpecHelpers

  context "valid link" do
    scenario "sees link on index" do
      user = login_user
      fill_in "Title", with: "Google"
      fill_in "Url", with: "http://google.com"
      click_on "Create new link"

      expect(current_path).to eq "/links"
      expect(page).to have_content "Added new link: Google"
      within(".links") do
        expect(page).to have_link("Google")
      end
    end
  end

  context "invalid link submitted" do
    scenario "does not link on index page" do
      user = login_user
      fill_in "Title", with: "Google"
      fill_in "Url", with: "Woah woah woah"
      click_on "Create new link"

      expect(current_path).to eq "/links"
      expect(page).to_not have_content "Added new link: #{title}"
      expect(page).to have_content "Not valid link submission"
      within(".links") do
        expect(page).to_not have_link(title)
      end
    end
  end
end
