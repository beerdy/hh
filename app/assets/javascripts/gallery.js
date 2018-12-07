document.addEventListener("turbolinks:load", function(){
  $(".product-images img").on("click", function(e) {
      var href = $(this).attr('src');
      mrgallery.winny(href);
      return false;
  });
});

var mrgallery = {
  winny: function(href){
    $('body').append('<div class="MrGallery animated fadeIn" onclick="mrgallery.close(this)"><div class="ImgOpened animated jackInTheBox" style="background-image:url(\''+href+'\');"></div></div>');
    return false;
  },
  close: function(e){
      $(e).remove();
      return false;
  }
}