class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    @events = Event.scoped
    #@events = @events.after(params['start']) if (params['start'])
    #@events = @events.before(params['end']) if (params['end'])
    @events = @events.where(main_event_id: params[:main_event_id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    main_event = MainEvent.find(params[:main_event_id])
    params[:event][:main_event_id] = params[:main_event_id]
    params[:event][:starts_at] = Time.parse(params[:event]["starts_at(1i)"] + '-' + params[:event]["starts_at(2i)"] + '-' + params[:event]["starts_at(3i)"] + ' ' + params[:event]["starts_at(4i)"] + ':' + params[:event]["starts_at(5i)"])
    params[:event][:ends_at] = Time.parse(params[:event]["ends_at(1i)"] + '-' + params[:event]["ends_at(2i)"] + '-' + params[:event]["ends_at(3i)"] + ' ' + params[:event]["ends_at(4i)"] + ':' + params[:event]["ends_at(5i)"])
    (1..5).each do |i|
      params[:event].delete("starts_at(#{i}i)")
      params[:event].delete("ends_at(#{i}i)")
    end

    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(main_event_event_path(main_event), :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.js { head :ok}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def sign_up
    #TODO: check for current user
    event = Event.find(params[:id])
    event.users << current_user
    event.save!
    redirect_to [event.main_event, event]
  end

end
