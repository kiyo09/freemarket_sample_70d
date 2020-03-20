$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select class="exmain-detail-category__box--select" id="child_category" name="">
                        <option value="---" data-category="---">---</option>
                        ${insertHTML}
                      <select>`;
    $('.exmain-detail-category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="exmain-detail-category__box--select" id="grandchild_category" name="item[category_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                            </select>`;
    $('.exmain-detail-category').append(grandchildSelectHtml);
  }

  $(document).on('change', '#category_select', function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
    var productcategory = document.querySelector('#category_select').value;
    // ↑ productcategoryに選択した親のvalueを代入
    if (productcategory != ''){
    // ↑ productcategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { productcategory: productcategory },
        dataType: 'json'
      })
      .done(function(children){
        // 子カテゴリ以下を削除した後、送られてきたデータをchildrenに代入
        $('#child_category').remove();
        $('#grandchild_category').remove();
        // TODO: サイズ実装時にオブジェクト名を変更する
        $('#size_wrapper').remove();
        $('.exmain-detail-brand-input').val('');
          var insertHTML = '';
        children.forEach(function(child){
        // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        alert('ファイルの取得に失敗しました。');

      })
    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchild_category').remove();
      $('#size_wrapper').remove();
      $('.exmain-detail-brand-input').val('');
    }
  });


  // document､もしくは親を指定しないと発火しない
  $(document).on('change', '#child_category', function(){
    var productcategory = $('#child_category option:selected').data('category');
    if (productcategory != ''){
    $.ajax ({
      url: 'category_grandchildren',
      type: 'GET',
      data: { productcategory: productcategory },
      dataType: 'json'
    })
    .done(function(grandchildren){
      if (grandchildren.length != 0) {
        $('#grandchild_category').remove(); //子が変更された時、孫以下を削除する
        // TODO: サイズ実装時にオブジェクト名を変更する
        $('#size_wrapper').remove();
        $('.exmain-detail-brand-input').val('');
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchidrenBox(insertHTML);
      }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      alert('ファイルの取得に失敗しました。');
    })
    }else{
      $('#grandchild_category').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      // TODO: サイズ実装時にオブジェクト名を変更する
      $('#size_wrapper').remove();
      $('.exmain-detail-brand-input').val('');
    }
  });
});