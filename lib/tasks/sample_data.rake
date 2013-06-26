namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  admin = User.create!(name: "Example User",
                         email: "exampler@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         cell_no: "(123)4567890",
                         address: "Suite 614")
    admin.toggle!(:admin)
  
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                         cell_no: "(123)4567890",
                         address: "Suite 614")
    end
  end
end