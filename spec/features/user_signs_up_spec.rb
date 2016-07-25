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
end
