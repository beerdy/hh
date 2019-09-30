# dropzone
# auto discover rescue error W init in Turbolinks
Dropzone.autoDiscover = false

Dropzone.options.myAwesomeDropzone =
  init: () ->
    Dropzone.startStatus = true
    this.on "success", (file, response) ->
      $("#product-form").append '<input type="hidden" name="product[photos][]" value="'+response.id.$oid+'">'
      $("#event-form").append '<input type="hidden" name="event[photos][]" value="'+response.id.$oid+'">'

Dropzone.discover()
# END dropzone

#-----------------------------------#
#              TurboLinks           #
#-----------------------------------#
document.addEventListener "turbolinks:load", () ->
  # dropzone discover for turbolinks
  Dropzone.discover()
  # END dropzone discover for turbolinks
      
  $('.datepicker-block').datepicker 
    language: 'ru-RU'
    autoclose: true

  $('.timepicker-block').timepicker
    lang: { am: '', pm: '', AM: '', PM: '', decimal: '.', mins: 'мин.', hr: 'ч', hrs: 'hrs' }
    minTime: "08:00", 
    maxTime: "22:00",
    show24Hours: true,
    timeFormat: 'H:i'
    step: 60