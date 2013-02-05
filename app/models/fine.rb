class Fine < ActiveRecord::Base
  attr_accessible :amount, :brother_id, :date_assigned

  has_one :brother
end