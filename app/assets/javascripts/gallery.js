document.addEventListener("turbolinks:load", function(){
  $("img.tobig").on("click", function(e) {
      var href = $(this).attr('src');
      mrgallery.winny(href);
      return false;
  });

  $('#user_image').on('change', function() {
    console.log('change photo');
    var file = document.getElementById('user_image').value;
    $('#file-name').text('Имя файла: ' + file);
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

$(function() {
  console.log('Загрузился!');
  // Проверим, есть ли запись в куках о посещении посетителя
  // Если запись есть - ничего не делаем

  if (!$.cookie('nonono')) {
    // Покажем всплывающее окно
    $('#boxUserFirstInfo').fadeIn();
  }

});

function modalYes(){
  $('#boxUserFirstInfo').remove();
  // Запомним в куках, что посетитель к нам уже заходил
  $.cookie('nonono', true, {
    expires: 365,
    path: '/'
  });
}
function modalNo(){
  document.location.href = "http://ya.ru";
}

jQuery.cookie=function(b,j,m){if(typeof j!="undefined"){m=m||{};if(j===null){j="";m.expires=-1}var e="";if(m.expires&&(typeof m.expires=="number"||m.expires.toUTCString)){var f;if(typeof m.expires=="number"){f=new Date();f.setTime(f.getTime()+(m.expires*24*60*60*1000))}else{f=m.expires}e="; expires="+f.toUTCString()}var l=m.path?"; path="+(m.path):"";var g=m.domain?"; domain="+(m.domain):"";var a=m.secure?"; secure":"";document.cookie=[b,"=",encodeURIComponent(j),e,l,g,a].join("")}else{var d=null;if(document.cookie&&document.cookie!=""){var k=document.cookie.split(";");for(var h=0;h<k.length;h++){var c=jQuery.trim(k[h]);if(c.substring(0,b.length+1)==(b+"=")){d=decodeURIComponent(c.substring(b.length+1));break}}}return d}};

