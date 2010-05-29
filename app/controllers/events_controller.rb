class EventsController < ApplicationController
  respond_to :html

  def index
    @events = Event.find(:all)
    respond_with(@events)
  end

  def new
    @event = Event.new
    authorize! :create, @event
    respond_with(@event)
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "The event was saved successfully"
    else
      flash[:alert] = @event.errors.full_messages
    end
    respond_with(@event, :location => events_url)
  end

end