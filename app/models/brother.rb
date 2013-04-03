class Brother < ActiveRecord::Base
  attr_accessible :email, :name, :phone_number

  has_many :fines

  def create_user (password)
    @user = User.new(
      :email => self.email,
      :password => password
    )
    @user.save
  end
end