document.addEventListener "turbolinks:load", () ->
  $('.js-cart-item-add').on 'click', ->
    $(this).attr 'href', $(this).attr('href')+'&product_quantify='+$(this).parent().find('#product_quantify').val()