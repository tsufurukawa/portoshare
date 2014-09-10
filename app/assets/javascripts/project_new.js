$(document).ready(function() {
  $("#new_project").find("#continue-button").on("click", function() {
    $("#new_project #detailed-info-tab").addClass("active");
    $("#new_project #basic-info-tab").removeClass("active");
  });

  $("#new_project").find("#previous-button").on("click", function() {
    $("#new_project #basic-info-tab").addClass("active");
    $("#new_project #detailed-info-tab").removeClass("active");
  });

  $("#new_project").find("#second-continue-button").on("click", function() {
    $("#new_project #upload-photo-tab").addClass("active");
    $("#new_project #detailed-info-tab").removeClass("active");
  });

  $("#new_project").find("#second-previous-button").on("click", function() {
    $("#new_project #detailed-info-tab").addClass("active");
    $("#new_project #upload-photo-tab").removeClass("active");
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