require 'rails_helper'

RSpec.describe "As a visitor when I visit a passenger show page" do
  before :each do
    @southwest = Airline.create(name: "Southwest")
    @sw_flight_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    @sw_flight_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")
    @sw_flight_3 = @southwest.flights.create(number: "SW3", date: "04/19/19", time: "1200", departure_city: "Denver", arrival_city: "Las Vegas")
    @pax_1 = Passenger.create(name: "Jimmy", age: 23)
    @pax_2 = Passenger.create(name: "Timmy", age: 26)

    @sw_flight_1.passengers << @pax_1
    @sw_flight_3.passengers << @pax_1
    @sw_flight_2.passengers << @pax_2

    visit "/passengers/#{@pax_1.id}"
  end

  it "shows the passengers name and a section that displays all flight numbers for that pax" do
    expect(page).to have_content("#{@pax_1.name}")

    within "#pax-flight-list" do
      expect(page).to have_content("#{@sw_flight_1.id}")
      expect(page).to have_content("#{@sw_flight_3.id}")
    end
  end

  it "all flight numbers are links to that flights show page" do
    within "#pax-flight-list" do
      click_link "#{@sw_flight_1.id}"
      expect(current_path).to eq("/flights/#{@sw_flight_1.id}")
    end
  end

  it "shows a form for pax to fill in flight id to add a flight" do

    within "#add-flight-form" do
      fill_in :flight_id, with: "#{@sw_flight_2.id}"
      click_button "Add Flight"
    end
  end

  it "shows all added flights to the pax show page" do
    expect(current_path).to eq("/passengers/#{@pax_1.id}")
    within "#pax-flight-list" do
      expect(page).to have_content("#{@sw_flight_2.id}")
      expect(page).to have_content("#{@sw_flight_1.id}")
      expect(page).to have_content("#{@sw_flight_3.id}")
    end
  end
end
