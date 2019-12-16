# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV["MAILER_USERNAME"],
  password: ENV["MAILER_PASSWORD"],
  domain: ENV["MAILER_DOMAIN"],
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
