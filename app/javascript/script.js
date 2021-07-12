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

  $(window).on('load scroll',function (){
		$('.fadeIn').each(function(){
			//ターゲットの位置を取得
			var target = $(this).offset().top;
			//スクロール量を取得
			var scroll = $(window).scrollTop();
			//ウィンドウの高さを取得
			var height = $(window).height();
			//ターゲットまでスクロールするとフェードインする
			if (scroll > target - height){
				//クラスを付与
				$(this).addClass('fade-active');
			}
		});
	});

});