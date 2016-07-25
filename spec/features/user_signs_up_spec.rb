require 'rails_helper'

RSpec.feature "A user signs up for an account" do
  scenario "on the index page" do
    visit '/'
    click_on "Sign Up"

    expect(current_path).to eq "/users/new"
    fill_in "Email", with: "funthoughts@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create account"

    expect(current_path).to eq "/links"
    expect(page).to have_content "Thanks for signing up!"
  end
  describe "invalid signup" do
    context "not a unique email" do
      scenario "sees form again" do
        visit '/'
        click_on "Sign Up"

        fill_in "Email", with: "email@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Create account"

        visit '/'
        click_on "Sign Up"

        fill_in "Email", with: "email@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Create account"

        expect(page).to have_content "Invalid account details"
      end
    end

    context "passwords do not match" do
      scenario "sees form again" do
        visit '/'
        click_on "Sign Up"

        fill_in "Email", with: "newuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "notthepassword"
        click_on "Create account"

        expect(page).to have_content "Invalid account details"
      end
    end
  end
end
