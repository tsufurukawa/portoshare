$(document).ready(function() {
  $("#projects .page").infinitescroll({
    loading: {
      img: 'data:image/gif;base64,R0lGODlhAQABAHAAACH5BAUAAAAALAAAAAABAAEAAAICRAEAOw==',
      msgText: "",
      finishedMsg: ""
    },
    navSelector: "ul.pagination",
    nextSelector: "ul.pagination a[rel=next]",
    itemSelector: "#projects .project"
  });
}); 