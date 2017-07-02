class EventsController < ApplicationController
  def index
    if params[:search]
     @events = Event.search(params[:search])
   else
     @events = Event.upcoming
   end
  end

  def show
    @event = Event.find(params[:id])
  end
end
