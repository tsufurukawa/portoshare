$(document).ready(function() {
  $(".fa-thumbs-o-up").tooltip({
    placement: "auto left"
  });
});

$(document).ajaxComplete(function() {
  $(".fa-thumbs-o-up").tooltip({
    placement: "auto left"
  });
})
