class EmailerController < ApplicationController
   def sendmail
      email = params["email"]
     recipient = email["recipient"]
     subject = email["subject"]
     message = email["message"]
      mailer=Emailer.contact(recipient, subject, message)
      mailer.deliver
      return if request.xhr?
        render :text => 'Message sent successfully'

   end


   def index
      render :file => 'app\views\emailer\index.rhtml'
   end
end