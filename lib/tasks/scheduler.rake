desc "This task is called by the Heroku scheduler add-on"
task :update_recall => :environment do
  puts "Updating feed..."
  Recall.all
  puts "done."
end