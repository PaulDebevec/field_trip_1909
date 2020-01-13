require 'rails_helper'

RSpec.describe "As a visitor when I visit a flights show page I see
              - number
              - date
              - time
              - departure city
              - arrival city" do
  before :each do
    @southwest = Airline.create(name: "Southwest")
    @sw_flight_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    @sw_flight_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
    @pax_1 = Passenger.create(name: "Jimmy", age: 23)
    @pax_2 = Passenger.create(name: "Timmy", age: 26)

    @sw_flight_1.passengers << @pax_1
    @sw_flight_1.passengers << @pax_2

    visit "/flights/#{@sw_flight_1.id}"
  end

  it "shows the name of the airlines the flight belongs to and a passengers list by name" do

    expect(page).to have_content("Airline: #{@southwest.name}")
    expect(page).to have_content("#{@sw_flight_1.number}")
    expect(page).to have_content("#{@sw_flight_1.date}")
    expect(page).to have_content("#{@sw_flight_1.time}")
    expect(page).to have_content("#{@sw_flight_1.departure_city}")
    expect(page).to have_content("#{@sw_flight_1.arrival_city}")

    expect(page).to_not have_content("#{@sw_flight_2.number}")
    expect(page).to_not have_content("#{@sw_flight_2.date}")
    expect(page).to_not have_content("#{@sw_flight_2.time}")
    expect(page).to_not have_content("#{@sw_flight_2.departure_city}")
    expect(page).to_not have_content("#{@sw_flight_2.arrival_city}")

    within "#flight-pax" do
      expect(page).to have_content("Jimmy")
      expect(page).to have_content("Timmy")
    end
  end
end
