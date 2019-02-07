document.addEventListener "turbolinks:load", () ->
  $('.js-cart-item-add').on 'click', ->
    $(this).attr 'href', $(this).attr('href')+'&product_quantify=+1'
    count = $('.cart a').text()
    count = count.match(/\d+/)
    count = parseInt count
    count = count+1
    $('.cart a').text "Корзина (#{count})"

  $('.js-cart-item-del').on 'click', ->
    $(this).attr 'href', $(this).attr('href')+'&product_quantify=-90'
    $(this).parent('.iteam').remove()

  $('.js-cart-item-plus').on 'click', ->
    $(this).attr 'href', $(this).attr('href')+'&product_quantify=+1'
    count = parseInt $(this).parent().find('.count').text()
    $(this).parent().find('.count').text count+1
  
  $('.js-cart-item-minus').on 'click', ->
    count = parseInt $(this).parent().find('.count').text()
    $(this).attr 'href', $(this).attr('href')+'&product_quantify=-1' if count > 1
    $(this).parent().find('.count').text count-1 if count > 1