$(document).ready(function() {
  // Show ellipsis for overflowing text
  $("#project-show .text-container").dotdotdot({
    wrap: 'letter',
    watch: true,
    after: "<a class='readmore'>Read More</a>"
  });

  $("#project-show .readmore").on("click", function(e) {
    e.preventDefault();
    alert("hello there");
  });

  // Set height of bulletin-board
  setInterval(setHeight, 500)

  // // Popover
  // $("#project-show .wrapper").popover({
  //   content: $("#more-info-description").text()
  // });
});

var setHeight = function() {
  var $bulletinContentHeight = $("#bulletin-board-content").css("height");
  $("#board-background").height($bulletinContentHeight);
};