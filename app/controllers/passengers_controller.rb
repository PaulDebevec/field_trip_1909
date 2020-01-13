class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:passenger_id])
  end

  def add_flight
    pax = Passenger.find(params[:passenger_id])
    flight = Flight.find(params[:flight_id])
    pax.flights.update(flight: flight)
    pax.save
    redirect_to "/passengers/#{pax.id}"
  end
end
