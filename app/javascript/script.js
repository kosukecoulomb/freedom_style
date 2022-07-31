//アップロード画像プレビュー
document.addEventListener('turbolinks:load', function () {
  $(function() {
    const uploader = document.querySelector('.uploader');
    if (!uploader){ return false;}
    uploader.addEventListener('change', function (event) {
      //画像の読み込み
      const file = uploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        const image = reader.result;
        //元の画像とupload画像を入れ替える
        document.querySelector('.avatar').setAttribute('src', image);
      }
    });
  });
});



//スキッパー
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


//一番上に戻るボタン
document.addEventListener("turbolinks:load", function() {
  $('#top a').on('click', function (event) {
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});



//ヘッダーの自動隠し機能
var beforePos = 0;//スクロールの値の比較用の設定

function ScrollAnime() {
  const elemTop = $('#contents').offset().top;
	const scroll = $(window).scrollTop();
    //ヘッダーの出し入れをする
  if(elemTop > scroll || 0 > scroll - beforePos){
	//ヘッダーが上から出現する
	  $('#header').removeClass('UpMove');
	  $('#header').addClass('DownMove');
  } else {
	//ヘッダーが上に消える
    $('#header').removeClass('DownMove');
    $('#header').addClass('UpMove');
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


// 天気表示
document.addEventListener('turbolinks:load', function () {
  const API_KEY = gon.weather_key;
  $(function(){
  $('#btn').on('click', function() {
    // 入力された都市名でWebAPIに天気情報をリクエスト
    $.ajax({
      url: "https://api.openweathermap.org/data/2.5/weather?q=" + $('#cityname').val() + "&units=metric&appid=" + API_KEY,
      dataType : 'jsonp',
    }).done(function (data) {
      // 通信成功
      // 位置
      $('#place').text(data.name);
      // 天気アイコン
      $('#img').attr("src","http://openweathermap.org/img/w/" + data.weather[0].icon + ".png");
      $('#img').attr("alt",data.weather[0].main);
      // 最高気温
      $('#temp_max').text(data.main.temp_max);
      // 最低気温
      $('#temp_min').text(data.main.temp_min);
    }).fail(function (data) {
      // 通信失敗
      alert('通信に失敗しました。');
    });
  });
  });
});
