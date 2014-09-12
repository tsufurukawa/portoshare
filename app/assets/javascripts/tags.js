$(document).ready(function() {
  $("#project_tag_list").tokenInput('/tags.json', {
    theme: "mac",
    prePopulate: $("#project_tag_list").data('load'),
    preventDuplicates: true,
    tokenLimit: 5
  });
});