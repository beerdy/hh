document.addEventListener "turbolinks:load", () ->
  $('.js-bonuses-prize').on 'click', ->
    $(this).attr 'href', '/bonuses/move?count='+$(this).parent().find('#bonuses_quantify').val()+'&card='+$(this).parent().find('#bonuses_card').val()