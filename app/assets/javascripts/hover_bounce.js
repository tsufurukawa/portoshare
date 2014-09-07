$(document).ready(function() {
  $("#user-show #project-add-link").mouseenter(function() {
    $('#user-show #bounce-item').stop(true, true).effect('bounce', { times: 2, distance: 20 }, 500);
  });
});