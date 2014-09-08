$(document).ready(function() {
  $("#new_project").find("#continue-button").on("click", function() {
    $("#new_project li:last-child").addClass("active");
    $("#new_project li:first-child").removeClass("active");
  });

  $("#new_project").find("#previous-button").on("click", function() {
    $("#new_project li:first-child").addClass("active");
    $("#new_project li:last-child").removeClass("active");
  });

  $("#project_details")
    .on("cocoon:before-insert", function(e, detail_to_be_added) {
      detail_to_be_added.fadeIn("slow");
    })
    .on("cocoon:before-remove", function(e, detail) {
      $(this).data("remove-timeout", 1000);
      detail.slideUp("slow");
    });
});