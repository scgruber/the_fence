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
    til_whenever = params[:event].delete(:til_whenever)
    params[:event].delete(:finish) if til_whenever == true
    
    @event = Event.new(params[:event])
    
    if @event.save
      flash[:notice] = "The event was saved successfully"
    else
      flash[:alert] = @event.errors.full_messages
    end
    
    respond_with(@event) do |format|
      format.html { redirect_to event_url(@event) }
    end
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with(@event)
  end

end