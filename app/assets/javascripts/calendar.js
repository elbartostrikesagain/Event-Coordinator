$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
    var event_path = $.trim($('#main_event_events_path').html());
    var start_date = $.trim($('#first_event_date').html()).split("/");
    var start_month = parseInt(start_date[0]) -1;
    var start_day = parseInt(start_date[1]);
    var start_year = parseInt(start_date[2]);

	$('#calendar').fullCalendar({
  theme: true,
  editable: false,
  header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: $.trim($("#calendar_view").html()),
        month: start_month,
        date: start_day,
        year: start_year,
        height: 700,
        //slotMinutes: 15,

        loading: function(bool){
            if (bool)
                $('#loading').show();
            else
                $('#loading').hide();
        },

        // a future calendar might have many sources.
        eventSources: [{
            url: event_path,
            ignoreTimezone: true
        }],

        timeFormat: 'h:mm t{ - h:mm t} '
        //dragOpacity: "0.5",

        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        //eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
        //    updateEvent(event, event_path);
        //},

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        //eventResize: function(event, dayDelta, minuteDelta, revertFunc){
        //    updateEvent(event, event_path);
        //},

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        //eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        //}
	});
});


function updateEvent(the_event, event_path) {
    $.update(
        (event_path+ "/") + the_event.id,
      { event: { title: the_event.title,
                 starts_at: "" + the_event.start,
                 ends_at: "" + the_event.end,
                 description: the_event.description
               }
      },
      function (reponse) { alert('successfully updated task.'); }
    );
};