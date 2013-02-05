class Brother < ActiveRecord::Base
  attr_accessible :email, :name, :phone_number

  has_many :fines
end