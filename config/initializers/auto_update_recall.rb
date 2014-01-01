require 'rufus-scheduler'

s = Rufus::Scheduler.new
 
s.every '12h' do
	#Recall.all
end
 
#s.join