$( document ).on('turbolinks:load', function(){
  $('#use_billing').change(function(e) {
    if (this.checked) {
      $('#shipping_address_form').remove()
    }
  });
});
