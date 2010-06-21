class EventsController < ApplicationController
  respond_to :html

  def index
    @events = Event.find(:all)
    respond_with(@events)
  end

  def new
    @categories = Category.find(:all)
    @event = Event.new
    authorize! :create, @event
    respond_with(@event)
  end
  
  def create
    til_whenever = params[:event].delete(:til_whenever)
    params[:event].delete(:finish) if til_whenever == '1'
    
    @categories = Category.find(:all)
    @event = Event.new(params[:event])
    
    # authorize! :create, @event
    
    if @event.save
      flash[:notice] = "The event was saved successfully"
    else
      flash[:alert] = @event.errors.full_messages
    end
    
    respond_with(@event)
  end
  
  def edit
    @event = Event.find(params[:id])
    authorize! :edit, @event
    respond_with(@event)
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with(@event)
  end

end