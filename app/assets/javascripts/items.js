// ===============================================================
// 出品ページ
// 販売手数料、販売利益
// ===============================================================

$(function(){
  $("#item_price").on('keyup', function(e){
    e.preventDefault();
    var price = $("#item_price").val();
    if( 300 <= price && price <= 9999999) {
    var fee = Math.floor(price / 10);
    var profit = (price - fee);
    $(".fee-span").text(fee);
    $(".profit-span").text(profit);
    }
  })
});

// 別回答途中、後学の為残し
// $(function(){
//   $("#item_price").change(function(){
//     var price = $('#item_price').val();
//     var priceI = parseInt(price);
//     var fee = (priceI / 10);
//     var profit = (priceI - fee);
//     $(".fee-span").append(fee);
//     $(".profit-span").append(profit);
//   })
//     if($('#item_price').size()){
//       $("#item_price").change(function(){
//         console.log('hello');
//         $(".fee-span").unwrap();
//       })
//     }
//   });

// ===============================================================
// 出品ページ
// 複数画像出品
// ===============================================================

// $(function () {
//   var dropzone = $('.dropzone-area');
//   var dropzone2 = $('.dropzone-area2');
//   var images = [];
//   var inputs = [];
//   var input_area = $('.input_area');
//   var preview = $('#preview');
//   var preview2 = $('#preview2');

//   $(document).on('change', 'input[type= "file"].upload-image', function (event) {
//   var file = $(this).prop('files')[0];
//   var reader = new FileReader();
//   inputs.push($(this));
//   var image = $(`<div class= "img_view"><img></div>`);
//   reader.onload = function (e) {
//     var btn_wrapper = $('<div class="btn_wrapper"><div class="delete-img-btn">削除</div></div>');
//     image.append(btn_wrapper);
//     image.find('img').attr({
//       src: e.target.result
//     })
//   }
//   reader.readAsDataURL(file);
//   images.push(image);
//   if (images.length <= 4) {
//     $('#preview').empty();
//     $.each(images, function (index, image) {
//       image.data('image', index);
//       preview.append(image);
//     })
//     dropzone.css({
//       'width': `calc(100% - (20% * ${images.length}))`
//     })
//     // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
//   } else if (images.length == 5) {
//     $("#preview").empty();
//     $.each(images, function (index, image) {
//       image.data("image", index);
//       preview.append(image);
//     });
//     dropzone2.css({
//       display: "block"
//     });
//     dropzone.css({
//       display: "none"
//     });
//     preview2.empty();

//     // 画像が６枚以上のとき
//   } else if (images.length >= 6) {
//     // １〜５枚目の画像を抽出
//     var pickup_images1 = images.slice(0, 5);

//     // １〜５枚目を１段目に表示
//     $('#preview').empty();
//     $.each(pickup_images1, function (index, image) {
//       image.data('image', index);
//       preview.append(image);
//     })

//     // ６枚目以降の画像を抽出
//     var pickup_images2 = images.slice(5);

//     // ６枚目以降を２段目に表示
//     $.each(pickup_images2, function (index, image) {
//       image.data('image', index + 5);
//       preview2.append(image);
//     })

//     dropzone.css({
//       'display': 'none'
//     })
//     dropzone2.css({
//       'display': 'block',
//       'width': `calc(100% - (20% * ${images.length - 5}))`
//     })

//     // 画像が１０枚になったら枠を消す
//     if (images.length == 10) {
//       dropzone2.css({
//         display: "none"
//       });
//     }
//   }
//   var new_image = $(`<input name="item[images_attributes][${images.length}][image]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
//   input_area.prepend(new_image);
//   $.each(input_area.children(), function (index, input) {
//   })
//   });
//   $(document).on('click', '.delete-img-btn', function () {
//   var target_image = $(this).parent().parent();
//   $.each(input_area.children(), function (index, input) {
//     if (input.dataset.image == target_image.data('image')) {
//       input.remove();
//       target_image.remove();
//       var num = input.dataset.image
//       images.splice(num, 1);
//       inputs.splice(num, 1);
//       if (inputs.length == 0) {
//         $('input[type= "file"].upload-image').attr({
//           'data-image': 0
//         })
//       }
//     }
//   })
//   $.each(input_area.children(), function (index, input) {
//     input.dataset.image = index
//   })
//   $('input[type= "file"].upload-image:first').attr({
//     'data-image': inputs.length
//   })
//   $.each(inputs, function (index, input) {
//     var input = $(this)
//     input.attr({
//       'data-image': index
//     })
//     $('input[type= "file"].upload-image:first').after(input)
//   })
//   if (images.length <= 4) {
//     $('#preview').empty();
//     $.each(images, function (index, image) {
//       image.data('image', index);
//       preview.append(image);
//     })
//     dropzone.css({
//       display: "block",
//       width: `calc(100% - (20% * ${images.length}))`

//     })
//     dropzone2.css({
//       display: "none"
//     });
//     // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
//   } else if (images.length == 5) {
//     $("#preview").empty();
//     $.each(images, function (index, image) {
//       image.data("image", index);
//       preview.append(image);
//     });
//     dropzone2.css({
//       display: "block",
//       width: '100%'
//     });
//     dropzone.css({
//       display: "none"
//     });
//     preview2.empty();

//     // 画像が６枚以上のとき
//   } else if (images.length >= 6) {
//     // １〜５枚目の画像を抽出
//     var pickup_images1 = images.slice(0, 5);

//     // １〜５枚目を１段目に表示
//     $('#preview').empty();
//     $.each(pickup_images1, function (index, image) {
//       image.data('image', index);
//       preview.append(image);
//     })

//     // ６枚目以降の画像を抽出
//     var pickup_images2 = images.slice(5);

//     // ６枚目以降を２段目に表示
//     $.each(pickup_images2, function (index, image) {
//       image.data('image', index + 5);
//       preview2.append(image);
//     })
//     dropzone.css({
//       'display': 'none'
//     })
//     dropzone2.css({
//       'display': 'block',
//       'width': `calc(100% - (20% * ${images.length - 5}))`
//     })

//     // 画像が１０枚になったら枠を消す
//     if (images.length == 10) {
//       dropzone2.css({
//         display: "none"
//       });
//      }
//    }
//   })
// });




$(function(){
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `
                <div class="js-file_group" data-index="${num}">
                  <input type="file" class="abc" value="textarea" name="item[images_attributes][${num}][image]" id="item_images_attributes_${num}_image">
  
                </div>
                 `;
    return html;
  }
  // プレビュー用のhtml要素生成
  const buildImg = (index ,url)=>{
    const html = `<div class="js-remove-wrapper">
                    <img data-index="${index}" src="${url}" width="120px" height="120px">
                    <span class="js-remove" data-index="${index}">
                      削除
                    </span>
                  </div>
                  `;
    return html;
  };

  

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0,lastIndex);
  $('.hidden-destroy').hide();

 // file_fieldのnameに動的なindexをつける為の配列

  $('#image-box').on('change', '.abc', function(e) {
    // fileIndexの先頭の数字を使ってinputを作る
    const targetIndex =$(this).parent().data('index');
    const file =e.target.files[0];
    const blobUrl =window.URL.createObjectURL(file);
    if(img =$(`img[data-index="${targetIndex}"]`)[0]){
      img.setAttribute('image',blovUrl)
    }else{
      $('#previews').append(buildImg(targetIndex,blobUrl));
      $('#form-wrapper').append(buildFileField(fileIndex[0]));
      $(this).parent().css({'display':'none'});
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }

  });

  

  $('#image-box').on('click', '.js-remove', function() {
   const targetIndex = $(this).parent().data('index');
   const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
   if (hiddenCheck) hiddenCheck.prop('checked', true);
   $(this).parent().remove();
   $(`img[data-index="${targetIndex}"]`).remove();
   if ($('.abc').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});
