class EventsController < ApplicationController
  respond_to :html

  def index
    @events = Event.all
    
    if params[:category_ids]
      @events = @events.any_in(:category_ids => params[:category_ids])
    end
    
    if params[:query]
      @events = @events.any_of({:name => /#{params[:query]}/i},
                        {:description => /#{params[:query]}/i}) # TODO: find out...could this be dangerous?
    end
    
    if params[:sort] == "upcoming"
      @events = @events.upcoming
    end

    respond_with(@events)
  end

  def new
    authorize! :create, Event, :message => I18n.t('events.create.authorize_message')
    
    @categories = Category.find(:all)
    @event = Event.new
    respond_with(@event)
  end
  
  def create
    authorize! :create, Event, :message => I18n.t('events.create.authorize_message')
    
    @categories = Category.find(:all)
    @event = current_user.events.build(params[:event])
    
    if @event.save
      flash[:notice] = I18n.t('events.create.successful')
    else
      flash[:alert] = @event.errors.full_messages
    end
    
    respond_with(@event)
  end
  
  def update
    @event = Event.find(params[:id])
    
    authorize! :edit, @event, :message => I18n.t('events.edit.authorize_message')
    
    if @event.update_attributes(params[:event])
      flash[:notice] = I18n.t('events.edit.successful')
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