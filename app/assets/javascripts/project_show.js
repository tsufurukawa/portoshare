$(document).ready(function() {
  $("#project-show .text-container").dotdotdot({
    wrap: 'letter',
    watch: true
  });

  // Set height of bulletin-board
  setInterval(setHeight, 500)
});

var setHeight = function() {
  var $bulletinContentHeight = $("#bulletin-board-content").css("height");
  $("#board-background").height($bulletinContentHeight);
};