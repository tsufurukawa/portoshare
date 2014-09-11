$(document).ready(function() {
  var $form = $("#project-new, #project-edit");

  $form.find("#continue-button").on("click", function() {
    $form.find("#detailed-info-tab").addClass("active");
    $form.find("#basic-info-tab").removeClass("active");
  });

  $form.find("#previous-button").on("click", function() {
    $form.find("#basic-info-tab").addClass("active");
    $form.find("#detailed-info-tab").removeClass("active");
  });

  $form.find("#second-continue-button").on("click", function() {
    $form.find("#upload-photo-tab").addClass("active");
    $form.find("#detailed-info-tab").removeClass("active");
  });

  $form.find("#second-previous-button").on("click", function() {
    $form.find("#detailed-info-tab").addClass("active");
    $form.find("#upload-photo-tab").removeClass("active");
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