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

  //slideIn
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

  //slide
  $('.slider').slick({
    dots: true,
    autoplay: true,
    autoplaySpeed: 3000,
    slidesToScroll:1,
    slidesToShow: 3,
    pauseOnHover: false,
    arrows: true,
    responsive: [
      {
        breakpoint: 1025,
        settings: {
          slidesToShow: 1,
          arrows: false,
        }
      },
    ]
  });

  //right-side
  var $rank = $( '#right-sideJs' );
  $( '#rank-js' ).on( 'click', function(e) {
    e.preventDefault();
    $rank.toggleClass( 'add-active' );
  });

  $( '#rank-closeBtn, #tweets-back, #rank-link' ).on( 'click', function(e) {
    e.preventDefault();
    $rank.removeClass( 'add-active' );
  });

  //left-side
  var $search = $( '#left-sideJs' );
  $( '#search-js' ).on( 'click', function(e) {
    e.preventDefault();
    $search.toggleClass( 'add-active' );
  });

  $( '#search-closeBtn, #tweets-back' ).on( 'click', function(e) {
    e.preventDefault();
    $search.removeClass( 'add-active' );
  });


  //flash message
  setTimeout("$('.flash-message').fadeOut('slow')", 2000);
});