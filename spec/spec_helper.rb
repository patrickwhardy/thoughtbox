
RSpec.configure do |config|
  # config.before(:all) do
  #   current_user = User.where(email: "patrickwhardy@gmail.com", password_digest: " ").first_or_create!
  # end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end


  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end


  config.before(:each) do
    DatabaseCleaner.start
  end


  config.after(:each) do
    DatabaseCleaner.clean
  end

# config.include FactoryGirl::Syntax::Methods
# config.use_transactional_fixtures = false
# config.infer_spec_type_from_file_location!
# config.filter_rails_from_backtrace!


  # config.expect_with :rspec do |expectations|
  #   expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  # end
  #
  # config.mock_with :rspec do |mocks|
  #   mocks.verify_partial_doubles = true
  # end

end

# Shoulda::Matchers.configure do |config|
#   config.integrate do |with|
#     with.test_framework :rspec
#     with.library :rails
#   end
# end

module SpecHelpers
  def login_user
    user = User.create(email: "patrickwhardy@gmail.com", password: "password")
    visit '/'
    click_on "Log In"

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Log in"
    return user
  end
end
