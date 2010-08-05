class EventsController < ApplicationController
  respond_to :html

  def index
    @events = Event.all
    
    if params[:category_ids]
      @events = @events.any_in(:category_ids => params[:category_ids])
    end
    
    if params[:query]
      @events = @events.where(:name => /#{params[:query]}/i) # TODO: could this be dangerous?
      @events = @events + Event.where(:description => /#{params[:query]}/i) # TODO: hack hack hack
    end
    
    if params[:sort] == "upcoming" # TODO: test me
      @events.where(:start.gt => Time.now).asc(:start)
    end

    respond_with(@events)
  end

  def new
    @categories = Category.find(:all)
    @event = Event.new
    authorize! :create, @event, :message => I18n.t('events.create.authorize_message')
    respond_with(@event)
  end
  
  def create    
    @categories = Category.find(:all)
    @event = current_user.events.build(params[:event])
    
    authorize! :create, @event, :message => I18n.t('events.create.authorize_message') # TODO: test me
    
    if @event.save
      flash[:notice] = "The event was saved successfully."
    else
      flash[:alert] = @event.errors.full_messages
    end
    
    respond_with(@event)
  end
  
  def update
    @event = Event.find(params[:id])
    
    authorize! :edit, @event, :message => I18n.t('events.edit.authorize_message')
    
    if @event.update_attributes(params[:event])
      flash[:notice] = "The event was successfully updated."
    else
      # TODO this should be replaced with formtastic methods but I need to Cucumber it
      flash[:alert] = @event.errors.full_messages
    end
    
    respond_with(@event)
  end
  
  def edit
    @event = Event.find(params[:id])
    authorize! :edit, @event, :message => I18n.t('events.edit.authorize_message')
    respond_with(@event)
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with(@event)
  end

end