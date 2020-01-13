class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:passenger_id])
  end
end
