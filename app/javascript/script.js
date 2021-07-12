$( function() {
  (function() {

    //totop
    jQuery(window).on("scroll", function($) {
      if (jQuery(this).scrollTop() > 100) {
        jQuery('.totop').show();
      } else {
        jQuery('.totop').hide();
      }
    });

    $('.totop').click(function () {
      $('body,html').animate({
        scrollTop: 0
      }, 500);
      return false;
    });
    
  })();
});