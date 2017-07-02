require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "loads correct events" do
      event= Event.new starts_at: 1.day.from_now
      event.save(validate: false)
      get :index
      expect(assigns(:events)).to eq [event]
    end

    it "return upcoming events" do
      new_event_1 = Event.new(starts_at: DateTime.parse(('Sat, 9 Jul 2017, 8:00 PM+0700')))
      new_event_1.save!(validate: false)
      new_event_2 = Event.new(starts_at: DateTime.parse(('Sat, 8 Jul 2017, 8:00 PM+0700')))
      new_event_2.save!(validate: false)

      get :index
      expect(assigns(:events)).to eq [new_event_2, new_event_1]
    end

    it "return matched events when searching" do
      event = Event.new(name: "Fullstack Weekend")
      event.save!(validate: false)

      get :index, params: { search: "Fullstack" }
      expect(assigns(:events)).to eq [event]
    end

    it "return [] when there's no matched events" do
      event = Event.new(name: "Fullstack Weekend")
      event.save!(validate: false)

      get :index, params: { search: "Concert" }
      expect(assigns(:events)).to eq []
    end
  end

  describe "GET #show" do
    it "should render show template" do
      event = Event.new(name: "Ruby VietNam")
      event.save!(validate: false)

      get :show, params: { :id => event.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template("show")
    end
  end

end
