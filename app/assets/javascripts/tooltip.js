$(document).ready(function() {
  $(".fa-thumbs-o-up").tooltip({
    placement: "auto left"
  });

  $("#project-url a").tooltip({
    placement: "right"
  });
});

$(document).ajaxComplete(function() {
  $(".fa-thumbs-o-up").tooltip({
    placement: "auto left"
  });
})
