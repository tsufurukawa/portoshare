$(document).ready(function() {
  $("#projects .page").infinitescroll({
    loading: {
      img: "data:image/gif;base64,R0lGODlhAQABAHAAACH5BAUAAAAALAAAAAABAAEAAAICRAEAOw==",
      msgText: "<p class='text-danger text-center msgText'>Loading more projects...</p><div class='msgText progress'><div class='progress-bar progress-bar-striped active' role='progressbar' style='width: 100%'></div></div>",
      finishedMsg: "<div class='finishedMsg'><em class='text-danger'>There are no more projects.</em></div>"
    },
    navSelector: "ul.pagination",
    nextSelector: "ul.pagination a[rel=next]",
    itemSelector: "#projects .project"
  });
}); 