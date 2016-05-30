ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
  
module FixtureFileHelpers
  	def encrypted_password(password = 'password123')
  		User.new.send(:password_digest, password)
  	end
  end

  ActiveRecord::FixtureSet.context_class.send :include, FixtureFileHelpers

  # Returns true if a test user is logged in.
  def is_logged_in?
    	!session[:user_id].nil?
  end

  # Logs in a test user.
  def log_in_as(user, options = {})
  	if integration_test?
  		post new_user_session_path, session: { name: user.name, email: user.email,
  			encrypted_password: user.encrypted_password,
  			}
  		else
  			session[:user_id] = user.id
  		end
  	end

  # Log out in a test user.
  def log_out()
  	destroy_user_session_path
  end

end
