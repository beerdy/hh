document.addEventListener 'turbolinks:load', ->
  $('.js-bonuses-prize').on 'click', (e) ->
    e.preventDefault()
    CardBonuses = $(this).parent().find('#bonuses_quantify')
    CardNumber = $(this).parent().find('#bonuses_card')
    CardBonusesС = $(this).parent().find('#bonuses_quantify').val()
    CardNumberС = $(this).parent().find('#bonuses_card').val()
    $.ajax
      url: '/bonuses/move?count=' + CardBonuses.val() + '&card=' + CardNumber.val()
      type: 'post'
      dataType: 'json'
      beforeSend: ->
        CardBonuses.val 0
        CardNumber.val 0
        $('#mess').remove()
        $('.balli').append '<div id="messloading">Подождите...</div>'
        return
      success: (data) ->
        console.log data.status
        $('#messloading').remove()
        if data.status == 'errorservice'
          $('.balli').prepend '<div id="mess" class="ajaxerror"><b>Ошибка:</b> Поле карты введено неверно</div>'
        else if data.status == 'notenough'
          $('.balli').prepend '<div id="mess" class="ajaxerror"><b>Ошибка:</b> Недостаточно баллов на карте</div>'
        else
          BonusesCount = $('.bonuses b').text()
          BonusesCount = parseInt(BonusesCount) - parseInt(CardBonusesС)
          $('.bonuses b').text BonusesCount
          $('.balli').prepend '<div id="mess" class="ajaxok">Вы успешно отправили баллы (<b>' + CardBonusesС + '</b>) пользователю с картой <b>№' + CardNumberС + '</b></div>'
        return
      error: ->
        $('#messloading').remove()
        $('.balli').prepend '<div id="mess" class="ajaxerror"><b>Ошибка:</b> Сервис временно недоступен</div>'
        return
    return
