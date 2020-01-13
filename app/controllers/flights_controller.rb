class FlightsController < ApplicationController
  def show
    @flight = Flight.find(params[:flight_id])
  end
end
