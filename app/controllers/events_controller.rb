class EventsController < ApplicationController
  before_filter :require_login, :only => :sign_up
  # GET /events
  # GET /events.xml
  def index
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    @main_event = MainEvent.find(params[:main_event_id])
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
    @main_event = @event.main_event

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    main_event = MainEvent.find(params[:main_event_id])
    redirect_to main_event and return unless current_user && main_event.user.id == current_user.id
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @event_start = @event.starts_at.strftime('%m/%d/%Y %I:%M %p')
    @event_end = @event.ends_at.strftime('%m/%d/%Y %I:%M %p')
    redirect_to main_event_event_path(@event.main_event, @event) unless can? :update, @event
  end

  # POST /events
  # POST /events.xml
  def create
    main_event = MainEvent.find(params[:main_event_id])
    params[:event][:main_event_id] = params[:main_event_id]
    params[:event][:starts_at] = Time.strptime(params[:starts_at], '%m/%d/%Y %I:%M %p')
    params[:event][:ends_at] = Time.strptime(params[:ends_at], '%m/%d/%Y %I:%M %p')
    params[:event][:all_day] =  params[:event][:all_day] == "0"? false : true
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
    params[:event][:starts_at] = Time.strptime(params[:starts_at], '%m/%d/%Y %I:%M %p')
    params[:event][:ends_at] = Time.strptime(params[:ends_at], '%m/%d/%Y %I:%M %p')
    params[:event][:all_day] =  params[:event][:all_day] == "0"? false : true

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to([@event.main_event, @event], :notice => 'Event was successfully updated.') }
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
    main_event = @event.main_event
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(main_event_event_index_path(main_event)) }
      format.xml  { head :ok }
    end
  end

  def sign_up
    event = Event.find(params[:id])
    event.users << current_user
    event.main_event.workers << current_user unless current_user.registered_for?(event.main_event)
    event.save!
    redirect_to main_event_event_index_path(event.main_event)
  end

  def unregister
    event = Event.find(params[:id])
    user_count = event.users.where(_id: current_user.id).all.count
    event.user_ids.delete(current_user.id) if user_count > 0
    event.save!
    redirect_to main_event_event_index_path(event.main_event)
  end

end
