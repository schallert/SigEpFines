class CreateBrothers < ActiveRecord::Migration
  def change
    create_table :brothers do |t|
      t.string :name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
