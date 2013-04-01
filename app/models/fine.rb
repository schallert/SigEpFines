class Fine < ActiveRecord::Base
  attr_accessible :amount, :brother_id, :date_assigned
  belongs_to :brother
  
  validates :amount, :presence => true
  validates :amount, :numericality => { :greater_than_or_equal_to => 0.0 }

  # We use this to access number_to_currency
  # Kind of breaking MVC principles but fuck that
  include ActionView::Helpers::NumberHelper

  def formatted_date
    self.date_assigned.strftime("%m/%d/%Y").to_s
  end

  def formatted_amount
    number_to_currency(self.amount)
  end

  def self.parse_date (date)
    if date.empty?
      Date.today
    else
      begin
        Date.strptime(date, '%m/%d/%Y')
      rescue ArgumentError
        Date.today
      end
    end
  end

  def self.format_date (date)
    date.strftime('%m/%d/%Y')
  end
end