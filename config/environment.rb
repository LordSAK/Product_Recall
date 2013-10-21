# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ProductRecall::Application.initialize!
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :domain => "gmail.com",
   :authentication => :login,
   :charset => 'utf-8',
   :user_name => "saghirakhatri@gmail.com",
   :password => "khatriisgr8"
  }	
