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
  # Dropzone.discover()
  # END dropzone discover for turbolinks

  $('.product-images img').on 'click', (e) ->
    e.preventDefault()
    href = $(this).attr('src')
    mrgallery.open href
    false
  return
  mrgallery = 
    open: (href) ->
      $('body').append '<div class="MrGallery animated fadeIn" onclick="mrgallery.close(this)"><div class="ImgOpened animated jackInTheBox" style="background-image:url(\'' + href + '\');"></div></div>'
      false
    close: (e) ->
      $(e).remove()
      false