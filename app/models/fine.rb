class Fine < ActiveRecord::Base
  attr_accessible :amount, :brother_id, :date_assigned

  belongs_to :brother
end