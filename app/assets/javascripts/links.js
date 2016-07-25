$(document).ready(function(){
  $('.links').on("click", "button#change-status", function(){
    var button = $(this);
    var status = $(button).parent().attr('class');
    var id = $(button).parent().attr('id');
    var new_status = getNewStatus(status);
    $.ajax({type: 'PATCH',
            url: '/api/v1/links/'+id,
            data: {link: {read: new_status}},
            success: changeStatus($(this).parent(), status, currentFilter())
          });
  });

  $('#read-links').on("click", function(){
    showLinksByStatus("read");
    updateListStatus("read-list");
  });

  $('#unread-links').on("click", function(){
    showLinksByStatus("unread");
      updateListStatus("unread-list");
  });
});

function changeStatus(link, status, listFilter) {
  if (status === "read") {
    $(link).removeClass("read");
    $(link).addClass("unread");
    $(link).children("button")[0].innerHTML = "Mark as Read";
  } else {
    $(link).removeClass("unread");
    $(link).addClass("read");
    $(link).children("button")[0].innerHTML = "Mark as Unread";
  }
  if (listFilter !== "all") {
    showLinksByStatus(listFilter);
  }
}

function getNewStatus(status) {
  if (status === "read") { return false; }
  return true;
}

function currentFilter(){
  var links = $('.links');
  if ($(links).hasClass("unread-list")) { return "unread"; }
  if ($(links).hasClass("read-list"))   { return "read"; }
  return "all";
}

function showLinksByStatus(status) {
  var links = $('.links').children(0);
  for(var i=0; i<links.length; i++) {
    if (status === "read" && links.eq(i).hasClass("read")){
      links.eq(i).show();
    } else if (status === "unread" && links.eq(i).hasClass("unread")){
      links.eq(i).show();
    } else {
      links.eq(i).hide();
    }
  }
}

function updateListStatus(status) {
  var links = $('.links');
  links.attr("class", "links");
  if (status !== "all") {
    links.addClass(status);
  }
}
