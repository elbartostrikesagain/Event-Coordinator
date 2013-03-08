$(function() {
    $( "#starts_at" ).datetimepicker({
        ampm: true
    });
});
$(function() {
    $( "#ends_at" ).datetimepicker({
        ampm: true
    });
});


$(document).ready(function() {
    var dateFormat = /\d?\d\/\d?\d\/\d\d\d\d \d?\d:\d\d (AM|PM|am|pm)/
    $('#formSubmit').click(function() {
        var errors = false;
        if(!dateFormat.test($('#starts_at').val())){
            $('#starts_at').parent().parent().addClass('error');
            errors = true;
        }else
            $('#starts_at').parent().parent().removeClass('error')
        if(!dateFormat.test($('#ends_at').val())){
            $('#ends_at').parent().parent().addClass('error')
        errors = true;
        }else
            $('#ends_at').parent().parent().removeClass('error')
        if(errors)
            $('#formError').show();
        else
            $('.eventForm').submit();
    });
});