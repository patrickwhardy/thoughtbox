require 'rails_helper'

RSpec.feature "user can edit links" do
  include SpecHelpers

  context "change link with valid title and url" do
    scenario "link title and url changes" do
      title = "Google"
      url = "http://google.com"
      new_title = "Yahoo"
      new_url = "http://yahool.com"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"

      click_on "Edit link"
      expect(current_path).to eq edit_link_path(link)

      fill_in "Title", with: new_title
      fill_in "Url", with: new_url
      click_on "Edit link"

      expect(current_path).to eq "/links"
      expect(page).to have_content "Successfully updated!"

      within("##{link.id}") do
        expect(page).to_not have_link(title)
        expect(page).to have_link(new_title)
      end
    end
  end

  context "change link with invalid title" do
    scenario "sees re-rendering of form" do
      title = "Google"
      url = "http://google.com"
      new_title = ""
      new_url = "http://yahoo.com"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"

      click_on "Edit link"
      fill_in "Title", with: new_title
      fill_in "Url", with: new_url
      click_on "Edit link"

      expect(page).to have_content "Update Unsuccessful!"

      visit "/links"
      within("##{link.id}") do
        expect(page).to have_link(title)
      end
    end
  end

  context "change link with invalid url" do
    scenario "sees re-rendering of form" do
      title = "Google"
      url = "http://google.com"
      new_title = "New title"
      new_url = "not a valid url"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"

      click_on "Edit link"
      fill_in "Title", with: new_title
      fill_in "Url", with: new_url
      click_on "Edit link"

      expect(page).to have_content "Update Unsuccessful!"

      visit "/links"
      within("##{link.id}") do
        expect(page).to have_link(title)
        expect(page).to_not have_link(new_title)
      end
    end
  end
end
