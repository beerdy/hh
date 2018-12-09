document.addEventListener "turbolinks:load", () ->
  $('.js-bonuses-prize').on 'click', ->
    $(this).attr 'href', $(this).attr('href')+'?count='+$(this).parent().find('#bonuses_quantify').val()+'&card='+$(this).parent().find('#bonuses_card').val()