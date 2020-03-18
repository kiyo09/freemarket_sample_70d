// プレビュー機能
  //'change'イベントでは$(this)で要素が取得できないため、 'click'イベントを入れた。
  //これにより$(this)で'input'を取得することができ、inputの親要素である'li'まで辿れる。

  $(document).on('click', '.image_upload', function(){
    //inputの要素はクリックされておらず、inputの親要素であるdivが押されている。
    //だからdivのクラス名をclickした時にイベントが作動。
    //div（this）から要素を辿ればinputを指定することが可能。

    //$liに追加するためのプレビュー画面のHTML。
    var preview = $('<div class="image-preview__wapper"><img class="preview"></div><div class="image-preview_btn"><div class="image-preview_btn_delete">削除</div></div>'); 
    //次の画像を読み込むためのinput。 
    var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text"><i class="fa fa-camera"></i><div class="input-area"><input name="item[images_attributes][#{@item.images.count}][src]",class="hidden image_upload" type="file"></div></div></label></li>`)
    $ul = $('#previews')
    $li = $(this).parents('li');
    $label = $(this).parents('.upload-label');
    $inputs = $ul.find('.image_upload');
    //inputに画像を読み込んだら、"プレビューの追加"と"新しいli追加"処理が動く
    $('.image_upload').on('change', function (e) {
      //inputで選択した画像を読み込む
      var reader = new FileReader();


      // プレビューに追加させるために、inputから画像ファイルを読み込む。
      reader.readAsDataURL(e.target.files[0]);

      //画像ファイルが読み込んだら、処理が実行される。 
      reader.onload = function(e){
        //previewをappendで追加する前に、プレビューできるようにinputで選択した画像を<img>に'src'で付与させる
        // つまり、<img>タグに画像を追加させる
        $(preview).find('.preview').attr('src', e.target.result);
      }

      //inputの画像を付与した,previewを$liに追加。
      $li.append(preview);

      //プレビュー完了後は、inputを非表示にさせる。これによりプレビューだけが残る。
      $label.css('display','none'); // inputを非表示
      $li.removeClass('input');     // inputのクラスはjQueryで数を数える時に邪魔なので除去
      $li.addClass('image-preview'); // inputのクラスからプレビュー用のクラスに変更した
      $lis = $ul.find('.image-preview'); // クラス変更が完了したところで、プレビューの数を数える。 
      $('#previews li').css({
        'width': `128px`,
        'height': `128px`
      })




      //"ul"に新しい"li(inputボタン)"を追加させる。
      if($lis.length <= 4 ){
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `calc(100% - (20% * ${$lis.length}))`
        })
      }
      else if($lis.length == 5 ){
        $li.addClass('image-preview');
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `100%`
        })
      }
      // ９個のプレビューのとき、1個のinputを追加。最後の数は9です。
      else if($lis.length <= 9 ){
        $li.addClass('image-preview');
        $ul.append(append_input)
        $('#previews li:last-child').css({
          'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
        })
      }
      //inputの最後の"data-image"を取得して、input nameの番号を更新させてる。
      // これをしないと、それぞれのinputの区別ができず、最後の1枚しかDBに保存されません。
      // 全部のプレビューの番号を更新することで、プレビューを削除して、新しく追加しても番号が1,2,3,4,5,6と綺麗に揃う。だから全部の番号を更新させる
      $inputs.each( function( num, input ){
        //nameの番号を更新するために、現在の番号を除去
        $(input).removeAttr('name');
        $(input).attr({
          name:"product[images_attributes][" + num + "][name]",
          id:"product_images_attributes_" + num + "_name"
        });
      });

    });
  });

  //削除ボタンをクリックしたとき、処理が動く。
$(document).on('click','.image-preview_btn_delete',function(){
  var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text">ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード<div class="input-area"><input class="hidden image_upload" type="file"></div></div></label></li>`)
  $ul = $('#previews')
  $lis = $ul.find('.image-preview');
  $input = $ul.find('.input');
  $ul = $('#previews')
  $li = $(this).parents('.image-preview');


  //"li"ごと削除して、previewとinputを削除させる。
  $li.remove();

  // inputボタンのサイズを更新する、または追加させる
  // まずはプレビューの数を数える。
  $lis = $ul.find('.image-preview');
  $label = $ul.find('.input');
  if($lis.length <= 4 ){
    // inputのサイズを変更
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * ${$lis.length}))`
    })
  }
  else if($lis.length == 5 ){
    // inputのサイズを変更
    $('#previews li:last-child').css({
      'width': `100%`
    })
  }
  else if($lis.length < 9 ){
    // inputのサイズを変更
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
    })
  }
  else if($lis.length == 9 ){
    $ul.append(append_input) // 9個の時だけ、新しいinputを追加してやる
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
    })
  }
});





// $(function(){
//   //DataTransferオブジェクトで、データを格納する箱を作る
//   var dataBox = new DataTransfer();
//   //querySelectorでfile_fieldを取得
//   var file_field = document.querySelector('input[type=file]')
//   //fileが選択された時に発火するイベント
//   $('#img-file').change(function(){
//     //選択したfileのオブジェクトをpropで取得
//     var files = $('input[type="file"]').prop('files')[0];
//     $.each(this.files, function(i, file){
//     //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
//     var fileReader = new FileReader();

//     //DataTransferオブジェクトに対して、fileを追加
//     dataBox.items.add(file)
//     //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
//     file_field.files = dataBox.files

//  var num = $('.item-image').length + 1 + i
//       fileReader.readAsDataURL(file);
// 　　　 //画像が10枚になったら超えたらドロップボックスを削除する
//       if (num == 10){
//         $('.exmain-image__input').css('display', 'none')   
//       }
//       //読み込みが完了すると、srcにfileのURLを格納
//       fileReader.onloadend = function() {
//         var src = fileReader.result
//         var html= `<div class='item-image' data-image="${file.name}">
//                     <div class=' item-image__content'>
//                       <div class='item-image__content--icon'>
//                         <img src=${src} width="114" height="80" >
//                       </div>
//                     </div>
//                     <div class='item-image__operetion'>
//                       <div class='item-image__operetion--delete'>削除</div>
//                     </div>
//                   </div>`
//         //image_box__container要素の前にhtmlを差し込む
//       $('.exmain-image__input').before(html);
//     };
//     //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
//     $('.exmain-image__input').attr('class', `item-num-${num}`)
//     });
//   });
// });

// $(document).on("click", '.item-image__operetion--delete', function(){
//   //プレビュー要素を取得
//   var target_image = $(this).parent().parent()
//   //プレビューを削除
//   target_image.remove();
//   //inputタグに入ったファイルを削除
//   file_field.val("")
// })






$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][image]"
                    id="item_images_attributes_${index}_image"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

//   // file_fieldのnameに動的なindexをつける為の配列
//   let fileIndex = [1,2,3,4,5,6,7,8,9,10];

//   $('.exmain-image__input').on('change', '.js-file', function(e) {
//     // fileIndexの先頭の数字を使ってinputを作る
//     $('.exmain-image__input').append(buildFileField(fileIndex[0]));
//     fileIndex.shift();
//     // 末尾の数に1足した数を追加する
//     fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
//   });

//   $('.exmain-image__input').on('click', '.js-remove', function() {
//     $(this).parent().remove();
//     // 画像入力欄が0個にならないようにしておく
//     if ($('.js-file').length == 0) $('.exmain-image__input').append(buildFileField(fileIndex[0]));
//   });
// });