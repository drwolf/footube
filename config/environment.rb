# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Footube::Application.initialize!

# don't validate the ssl certificate of the local mailserver
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false