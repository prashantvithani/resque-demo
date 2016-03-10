class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name

      t.timestamps null: false
    end

    1000.times { |n| Company.create!(name: "Company #{n}") }
  end
end
