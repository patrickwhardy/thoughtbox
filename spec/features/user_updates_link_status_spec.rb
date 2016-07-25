require 'rails_helper'

RSpec.feature "user can change link status" do
  include SpecHelpers

  context "link has unread status" do
    scenario "sees link become read" do
      title = "Google"
      url = "http://google.com"
      user = login_user
      link = user.links.create(title: title, url: url)
      visit "/links"
      expect(page).to_not have_selector(:link_or_button, 'Mark as Unread')
      click_on "Mark as Read"

      # if selenium ever works do something like this:
      # within(".links") do
      #   expect(page).to have_css(".read")
      #   expect(page).to_not have_css(".unread")
      # end
    end
  end

  context "link has read status" do
    scenario "sees link become unread" do
      title = "Google"
      url = "http://google.com"
      user = login_user
      link = user.links.create(title: title, url: url, read: true)

      visit "/links"
      expect(page).to_not have_selector(:link_or_button, 'Mark as Read')
      click_on "Mark as Unread"

      expect(current_path).to eq "/links"

      # within(".links") do
      #   expect(page).to have_css(".unread")
      #   expect(page).to_not have_css(".read")
      # end
    end
  end
end
