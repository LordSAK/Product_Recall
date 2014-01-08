require 'rufus-scheduler'

s = Rufus::Scheduler.new
 
s.every '10m' do
 	puts "Recalls updating...."
	Recall.all
	puts "Recalls updated"
end
 
#s.join