class CreateFines < ActiveRecord::Migration
  def change
    create_table :fines do |t|
      t.decimal :amount
      t.date :date_assigned
      t.integer :brother_id

      t.timestamps
    end
  end
end
