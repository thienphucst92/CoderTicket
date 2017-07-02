require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".upcoming" do
    it "returns [] when there are no events" do
      events = Event.upcoming
      expect(events).to eq([])
    end

    it "returns 1 event when there is one event" do
      event = Event.new(name: "Amanda Grande")
      event.save!(validate: false)
      expect(Event.upcoming.count).to eq(1)
    end

    it "returns only upcoming events" do
      new_event_1 = Event.new(starts_at: DateTime.parse(('Sat, 9 Jul 2017, 8:00 PM+0700')))
      new_event_1.save!(validate: false)
      new_event_2 = Event.new(starts_at: DateTime.parse(('Sat, 8 Jul 2017, 8:00 PM+0700')))
      new_event_2.save!(validate: false)

      expect(Event.upcoming).to eq([new_event_2, new_event_1])
    end

  end

  describe "#venue_name" do
    it "returns nil if there's no venue" do
      event = Event.new
      expect(event.venue_name).to be_nil
    end

    it "returns venue name if there's a venue" do
      event = Event.new
      event.venue = Venue.new(name: "Coffee House")
      expect(event.venue_name).to eq "Coffee House"
    end
  end

  describe "#search" do
    it "returns [] if there's no matched records" do
      event = Event.new(name: "Fullstack Weekend")
      event.save!(validate: false)

      expect(Event.search("asdf").count).to eq 0
    end

    it "should returns matched records" do
      event = Event.new(name: "Fullstack Weekend")
      event.save!(validate: false)

      expect(Event.search("Fullstack").count).to eq 1
    end
  end

  describe "#ticket_types" do
    it 'should have ticket with different prices' do
      
    end
  end
end
