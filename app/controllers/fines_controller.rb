class FinesController < ApplicationController
  def index
    @fines = Fine.order("date_assigned DESC")
  end

  def show
    @fine = Fine.find(params[:id])
  end

  def new
    @fine = Fine.new
    @fine.date_assigned ||= Fine.format_date(Date.today)
  end

  def create
    @fine = Fine.new(params[:fine])

    date = params[:fine][:date_assigned]
    @fine.date_assigned = Fine.parse_date(date)

    if @fine.save
      flash[:success] = "Fine of #{@fine.formatted_amount} to #{@fine.brother.name} created"
      redirect_to root_path
    else
      @fine.date_assigned = @fine.formatted_date
      render 'new'
    end
  end

  def destroy
    @fine = Fine.find(params[:id])
    if @fine.destroy
      flash[:danger] = "Fine of #{@fine.formatted_amount} to #{@fine.brother.name} removed"
      redirect_to root_path
    end
  end

  def remind
    @fine = Fine.find(params[:id])
    @fine.phone_reminder
    flash[:success] = "Reminder sent"
    redirect_to show_fine_path @fine
  end
end
