window.addEventListener('turbolinks:load', () => {
    const uploader = document.querySelector('.uploader');
    uploader.addEventListener('change', (e) => {
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const coordinate_image = reader.result;
        document.querySelector('.avatar').setAttribute('src', coordinate_image);
      }
    });
});

$(document).ready(function () {
  $("#theTarget").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'slide',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : 'block',
    // 子要素の種類('div' or 'img')
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 3000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});


document.addEventListener("turbolinks:load", function() {
  $(function() {
  $('#top a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});
})



var beforePos = 0;//スクロールの値の比較用の設定

//スクロール途中でヘッダーが消え、上にスクロールすると復活する設定を関数にまとめる
function ScrollAnime() {
    var elemTop = $('#contents').offset().top;//#area-2の位置まできたら
	var scroll = $(window).scrollTop();
    //ヘッダーの出し入れをする
    if(scroll == beforePos) {
		//IE11対策で処理を入れない
    }else if(elemTop > scroll || 0 > scroll - beforePos){
		//ヘッダーが上から出現する
		$('#header').removeClass('UpMove');	//#headerにUpMoveというクラス名を除き
		$('#header').addClass('DownMove');//#headerにDownMoveのクラス名を追加
    }else {
		//ヘッダーが上に消える
        $('#header').removeClass('DownMove');//#headerにDownMoveというクラス名を除き
		$('#header').addClass('UpMove');//#headerにUpMoveのクラス名を追加
    }
    
    beforePos = scroll;//現在のスクロール値を比較用のbeforePosに格納
}


// 画面をスクロールをしたら動かしたい場合の記述
$(window).scroll(function () {
	ScrollAnime();//スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ
});

// ページが読み込まれたらすぐに動かしたい場合の記述
$(window).on('load', function () {
	ScrollAnime();//スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ
});

//リンク先のidまでスムーススクロール
    var headerH = $("#header").outerHeight(true);//headerの高さを取得    
    $('#g-navi li a').click(function () {
	var elmHash = $(this).attr('href'); 
	var pos = $(elmHash).offset().top-headerH;//header分の高さを引いた高さまでスクロール
	$('body,html').animate({scrollTop: pos}, 1000);
	return false;
});
