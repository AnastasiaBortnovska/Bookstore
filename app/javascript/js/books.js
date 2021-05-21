$(document).on('turbolinks:load', function() {
    $('.btn-minus-js').click(function() {
      let input = $(this).parent().find('.book-quantity-js')
      let quantity = Number(input.val())
      if (quantity > 1) {
        input.val(quantity - 1)
      }
    })
  
    $('.btn-plus-js').click(function() {
      let input = $(this).parent().find('.book-quantity-js')
      input.val(Number(input.val()) + 1)
    })

    $('.read-more-js').click(function() {
      let btn_link = $('.read-more-js')
      let description_end = $('.end-of-description-js')
      if (description_end.css('display') == 'none') {
        btn_link.text('Close')
        description_end.show()
      } else {
        btn_link.text('Read more')
        description_end.hide()
      }
    })
})
