require 'rails_helper'

RSpec.feature "User logs out" do
  include SpecHelpers

  scenario "from login" do
    user = login_user
    visit '/links'
    click_on "Sign Out"

    expect(current_path).to eq '/login'
  end
end
