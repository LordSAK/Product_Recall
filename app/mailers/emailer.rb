class Emailer < ActionMailer::Base
  default from: 'saghirakhatri@gmail.com'

def contact(recipient, subject, message)
      @subject = subject
      @recipients = recipient
      
      @body= message
      @headers = {}
      mail(:to =>  @recipients,:subject => @subject,:body => @body)
   end 
end