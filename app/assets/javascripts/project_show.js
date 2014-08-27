$(document).ready(function() {
  $(".caption").dotdotdot({
    wrap: 'letter',
    watch: true
  });

  // Set height of bulletin-board
  setInterval(setHeight, 500)
});

var setHeight = function() {
  var $bulletinContentHeight = $(".bulletin-board-content").css("height");
  $(".bulletin-board-wrapper > img").height($bulletinContentHeight);
};