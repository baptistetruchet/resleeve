class BookingsController < ApplicationController
  before_action :set_body, only: [:new, :create]

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.body = @body
    @booking.user = current_user
    @booking.status = "pending"
    authorize @booking
    if @booking.save!
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def set_body
    @body = Body.find(params[:body_id])
  end

  def booking_params
    params.require(:booking).permit(:date_in, :date_out)
  end
end
