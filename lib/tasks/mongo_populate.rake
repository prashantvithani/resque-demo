namespace :mongo_populate do
  desc "populate mongodb"
  task fill_in: :environment do
    1000.times { |n| Person.create(name: "Person #{n}") }
  end
end
