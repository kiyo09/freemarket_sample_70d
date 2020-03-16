$(function() {
  // 子カテゴリーを追加するための処理です。
    function buildChildHTML(child){
      var html =`<a class="child_category" id="${child.id}" 
                  href="/categories/${child.id}">${child.name}</a>`;
      return html;
    }
  
    $(".parent_category").on("mouseover", function() {
      var parent_id = this.id//どのリンクにマウスが乗ってるのか取得します
      $(".child_category").remove();//一旦出ている子カテゴリ消します！
      $(".grand_child_category").remove();
      $.ajax({
        type: 'GET',
        url: '/categories/new',//とりあえずここでは、newアクションに飛ばしてます
        data: {parent_id: parent_id},//どの親の要素かを送ります　params[:parent_id]で送られる
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {//帰ってきた子カテゴリー（配列）
          var html = buildChildHTML(child);//HTMLにして
          $(".children_list").append(html);//リストに追加します
        })
      });
    });
  
    // 孫カテゴリを追加する処理です　基本的に子要素と同じです！
    function buildGrandChildHTML(child){
      var html =`<a class="grand_child_category" id="${child.id}"
                 href="/categories/${child.id}">${child.name}</a>`;
      return html;
    }
  
    $(document).on("mouseover", ".child_category", function () {//子カテゴリーのリストは動的に追加されたHTMLのため
      var id = this.parent.id
      $.ajax({
        type: 'GET',
        url: '/categories/new',
        data: {parent_id: id},
        dataType: 'json'
      }).done(function(children) {
        children.forEach(function (child) {
          var html = buildGrandChildHTML(child);
          $(".grand_children_list").append(html);
        })
        $(document).on("mouseover", ".child_category", function () {
          $(".grand_child_category").remove();
        });
      });
    });  
  });