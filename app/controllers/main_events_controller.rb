class MainEventsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :register, :unregister]
  before_filter :require_login, only: [:register, :unregister]

  # GET /main_events
  # GET /main_events.json
  def index
    current_user_id = current_user.nil? ? nil : current_user.id
    @main_events = MainEvent.where(user_id: current_user_id)
    @my_events = Event.any_in(user_ids: [current_user_id]).all if current_user_id
    @registered_events = current_user.registered_main_events.to_a
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @main_events }
    end
  end

  # GET /main_events/1
  # GET /main_events/1.json
  def show
    @main_event = MainEvent.find(params[:id])
    @events = Event.where(main_event_id: @main_event.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end

  end

  # GET /main_events/new
  # GET /main_events/new.json
  def new
    @main_event = MainEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @main_event }
    end
  end

  # GET /main_events/1/edit
  def edit
    @main_event = MainEvent.find(params[:id])
  end

  # POST /main_events
  # POST /main_events.json
  def create
    @main_event = MainEvent.new(params[:main_event])
    @main_event.user = current_user

    respond_to do |format|
      if @main_event.save
        format.html { redirect_to @main_event, notice: 'Main event was successfully created.' }
        format.json { render json: @main_event, status: :created, location: @main_event }
      else
        format.html { render action: "new" }
        format.json { render json: @main_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /main_events/1
  # PUT /main_events/1.json
  def update
    @main_event = MainEvent.find(params[:id])

    respond_to do |format|
      if @main_event.update_attributes(params[:main_event])
        format.html { redirect_to @main_event, notice: 'Main event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @main_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_events/1
  # DELETE /main_events/1.json
  def destroy
    @main_event = MainEvent.find(params[:id])
    @main_event.destroy

    respond_to do |format|
      format.html { redirect_to main_events_url }
      format.json { head :no_content }
    end
  end
  
  def register
    main_event = MainEvent.find(params[:id])
    main_event.workers << current_user if current_user && !current_user.registered_for?(main_event)
    if main_event.save!
      redirect_to main_event, notice: "You are now registered for #{main_event.name}"
    else
      redirect_to main_event, error: "Failed to register you for #{main_event.name}"
    end
  end

  def unregister
    main_event = MainEvent.find(params[:id])
    users_events = Event.where(user_ids: current_user.id).all
    #slooooowww
    users_events.each do |event|
      if event.main_event.id == main_event.id
        flash[:error] = "Please unregister from all events you are working before unregistering from #{main_event.name}"
        redirect_to main_event_event_index_path(main_event)
        return
      end
    end
    user_count = main_event.workers.where(_id: current_user.id).all.count
    main_event.workers.delete(current_user) if user_count > 0
    if main_event.save!
      redirect_to main_event, notice: "Succesfully unregistered for #{main_event.name}"
    else
      flash[:error] = "Failed to unregister you for #{main_event.name}"
      redirect_to main_event
    end
  end
end