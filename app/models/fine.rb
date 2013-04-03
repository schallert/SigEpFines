class Fine < ActiveRecord::Base
  attr_accessible :amount, :brother_id, :reason, :date_assigned
  belongs_to :brother
  
  validates :amount, :presence => true
  validates :amount, :numericality => { :greater_than_or_equal_to => 0.0 }

  # We use this to access number_to_currency
  # Kind of breaking MVC principles but fuck that
  include ActionView::Helpers::NumberHelper

  TWILIO_SID = CONFIG[:twilio_SID]
  TWILIO_TOKEN = CONFIG[:twilio_token]
  TWILIO_NUMBER = CONFIG[:twilio_number]

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

  def phone_reminder
    @brother = self.brother

    message = "REMINDER: you have an oustanding fine of #{self.formatted_amount} for \"#{self.reason}\""

    @client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_TOKEN)
    @client.account.sms.messages.create(
      :from => TWILIO_NUMBER,
      :to => @brother.phone_number,
      :body => message
    )
  end

  def email_reminder
    Notifier.reminder(self).deliver
  end

end