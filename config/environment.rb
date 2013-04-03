# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SigepFines::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => CONFIG[:smtp_user_name],
  :password => CONFIG[:smtp_password],
  :domain => CONFIG[:smtp_domain],
  :address => CONFIG[:smtp_address],
  :port => CONFIG[:smtp_port],
  :authentication => :plain,
  :enable_starttls_auto => true
}