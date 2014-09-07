$(document).ready(function() {
  // Show ellipsis for overflowing text
  $("#project-show .text-container").dotdotdot({
    wrap: 'letter',
    watch: true,
  });

  // TODO: Either modify or delete this functionality. As is, this code does not work.
  $("#project-show .readmore").on("click", function() {
    alert("hello there");
  });

  $("#project-show .hello").click(function() {
    alert("hello there howdy");
    return false;
  });

  // // Popover
  // $("#project-show .wrapper").popover({
  //   content: $("#more-info-description").text()
  // });
});