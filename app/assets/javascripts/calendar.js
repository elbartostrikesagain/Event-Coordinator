$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
    var event_path = $.trim($('#main_event_events_path').html())

	$('#calendar').fullCalendar({

  editable: true,
  header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        //TODO: load setting from rails
        defaultView: 'agendaDay',
        month: 4, 
        date: 25,
        year: 2012,
        height: 500,
        slotMinutes: 15,

        loading: function(bool){
            if (bool)
                $('#loading').show();
            else
                $('#loading').hide();
        },

        // a future calendar might have many sources.
        eventSources: [{
            url: event_path,
            color: 'yellow',
            textColor: 'black',
            ignoreTimezone: false
        }],

        timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5",

        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event, event_path);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event, event_path);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        }
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