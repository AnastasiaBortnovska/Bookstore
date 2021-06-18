$(document).on('turbolinks:load', function(){
    $('#destroy_confirmation').change(function() {
      $('#destroy_confirmation_button').prop('disabled', !$(this).is(':checked'))
      $('#destroy_confirmation_button').toggleClass('disabled', !$(this).is(':checked'))
    });
});
