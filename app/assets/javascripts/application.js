// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs

//= bootstrap-sprockets


//= require turbolinks
//=require_tree

<script type="text/javascript">

// 基本的な記述です。コンテンツ部分のID名を書いておきましょう。
var snapper = new Snap({
  element: document.getElementById('content')
});

// 以下はフリックやドラッグだけでなく、ボタンでも開いたり閉じたりできるようにする記述です。
var addEvent = function addEvent(element, eventName, func) {
  if (element.addEventListener) {
      return element.addEventListener(eventName, func, false);
  } else if (element.attachEvent) {
      return element.attachEvent("on" + eventName, func);
  }
};

// ボタンのID名と揃えておきましょう。
addEvent(document.getElementById('open-right'), 'click', function(){
  snapper.open('right');
});
</script>
