class MainEventsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:show, :index]

  # GET /main_events
  # GET /main_events.json
  def index
    @main_events = MainEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @main_events }
    end
  end

  # GET /main_events/1
  # GET /main_events/1.json
  def show
    @main_event = MainEvent.find(params[:id])
    @events = Event.scoped.where(main_event: @main_event.id)
    @events = @events.after(params['start']) if (params['start'])
    @events = @events.before(params['end']) if (params['end'])

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
end
