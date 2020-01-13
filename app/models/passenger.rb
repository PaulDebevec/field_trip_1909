class Passenger < ApplicationRecord
  validates_presence_of :name, :age

  has_many :passenger_flights
  has_many :flights, through: :passenger_flights

  # def add_flight(flight)
  #   pax.flights << flight
  # end
end
