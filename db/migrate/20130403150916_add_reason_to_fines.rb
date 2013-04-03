class AddReasonToFines < ActiveRecord::Migration
  def change
    add_column :fines, :reason, :string
  end
end
