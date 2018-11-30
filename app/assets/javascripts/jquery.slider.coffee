#-----------------------------------#
#              TurboLinks           #
#-----------------------------------#
document.addEventListener "turbolinks:load", () ->
  slideNow = 1
  slideCount = $('.slidewrapper').children().length
  slideInterval = 30000
  navBtnId = 0
  translateWidth = 0

  nextSlide = ->
    if slideNow == slideCount or slideNow <= 0 or slideNow > slideCount
      $('.slidewrapper').css 'transform', 'translate(0, 0)'
      slideNow = 1
    else
      translateWidth = -$('.intro').width() * slideNow
      $('.slidewrapper').css
        'transform': 'translate(' + translateWidth + 'px, 0)'
        '-webkit-transform': 'translate(' + translateWidth + 'px, 0)'
        '-ms-transform': 'translate(' + translateWidth + 'px, 0)'
      slideNow++
    return

  prevSlide = ->
    if slideNow == 1 or slideNow <= 0 or slideNow > slideCount
      translateWidth = -$('.ntro').width() * (slideCount - 1)
      $('.slidewrapper').css
        'transform': 'translate(' + translateWidth + 'px, 0)'
        '-webkit-transform': 'translate(' + translateWidth + 'px, 0)'
        '-ms-transform': 'translate(' + translateWidth + 'px, 0)'
      slideNow = slideCount
    else
      translateWidth = -$('.intro').width() * (slideNow - 2)
      $('.slidewrapper').css
        'transform': 'translate(' + translateWidth + 'px, 0)'
        '-webkit-transform': 'translate(' + translateWidth + 'px, 0)'
        '-ms-transform': 'translate(' + translateWidth + 'px, 0)'
      slideNow--
    return

#-----------------------------------#
#              TurboLinks           #
#-----------------------------------#
document.addEventListener "turbolinks:load", () ->
  switchInterval = setInterval(nextSlide, slideInterval)
  $('.intro').hover (->
    clearInterval switchInterval
    return
  ), ->
    switchInterval = setInterval(nextSlide, slideInterval)
    return
  $('.next-btn').click ->
    nextSlide()
    return
  $('.prev-btn').click ->
    prevSlide()
    return
  $('.slide-nav-btn').click ->
    navBtnId = $(this).index()
    if navBtnId + 1 != slideNow
      translateWidth = -$('.intro').width() * navBtnId
      $('.slidewrapper').css
        'transform': 'translate(' + translateWidth + 'px, 0)'
        '-webkit-transform': 'translate(' + translateWidth + 'px, 0)'
        '-ms-transform': 'translate(' + translateWidth + 'px, 0)'
      slideNow = navBtnId + 1
    return
  return