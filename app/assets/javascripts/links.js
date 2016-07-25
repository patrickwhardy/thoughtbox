$(document).ready(function(){
  console.log("hi");
  $('.links').on("click", "button#change-status", function(e){
    console.log("clicked");
    var button = $(this);
    var status = getStatus(button);
    var id = getId(button);
    var new_status = getNewStatus(status);
    var listFilter = getCurrentFilter();
    $.ajax({type: 'PATCH',
            url: '/api/v1/links/'+id,
            data: {link: {read: new_status}},
            success: changeStatus($(this).parent(), status, listFilter)
          });

  });

  $('#read-links').on("click", function(){
    showOnlyLinks("read");
    updateListStatus("read-list");
  });

  $('#unread-links').on("click", function(){
    showOnlyLinks("unread");
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
    showOnlyLinks(listFilter);
  }
}

function getStatus(button) {
  var linkStatus = $(button).parent().attr('class');
  var sind = linkStatus.indexOf(" ");
  return linkStatus.slice(sind+1);
}

function getId(button) {
  var id = $(button).parent().attr('id');
  var sid = id.indexOf("-");
  return id.slice(sid+1);
}

function getNewStatus(status) {
  if (status === "read") { return false; }
  return true;
}

function getCurrentFilter(){
  var links = $('.links');
  if ($(links).hasClass("unread-list")) { return "unread"; }
  if ($(links).hasClass("read-list"))   { return "read"; }
  return "all";
}
