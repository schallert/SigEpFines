require 'csv'

namespace :db do
  desc "create the database from a csv file"
  task :import_csv => :environment do
    path = File.join(Rails.root, "lib", "tasks", "brothers.csv")
    CSV.foreach(path) do |row|
      first_name = row[1]
      last_name = row[0]
      name = first_name + " " + last_name
      gmail_address = row[5]
      phone_number = row[6]
      Brother.create!(
        :name => name,
        :email => gmail_address + "@gmail.com",
        :phone_number => phone_number)
    end
  end
end