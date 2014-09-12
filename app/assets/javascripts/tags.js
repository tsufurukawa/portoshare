$(document).ready(function() {
  $("#project_tag_list").tokenInput('/tags.json', {
    theme: "mac",
    prePopulate: $("#project_tag_list").data('load'),
    preventDuplicates: true,
    tokenLimit: 5
  });

  if($("#project_errors").data('error')) {
    $("#project_details").find(".form-group").addClass('has-error');
  }
});