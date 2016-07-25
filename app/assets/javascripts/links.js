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

  $('#all-links').on("click", function(){
    showAllLinks();
    updateListStatus("all");
  });

  $('#alphabetical').on("click", function(){
    var sortedLinks = sortAlphabetically();
    $('.links').empty();
    addSortedLinks(sortedLinks);
  });

  $( "#link_filter" ).keyup(function(e) {
    $('.links').children(0).each(function(){
      var searchStr = $('#link_filter').val().toLowerCase();
      var title = $(this).children().first().text().toLowerCase();
      if (title.indexOf(searchStr) !== -1) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
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

function showAllLinks() {
  var links = $('.links').children(0);
  for(var i=0; i<links.length; i++) {
    links.eq(i).show();
  }
}

function sortAlphabetically() {
  var sortedLinks = $('.links').children(0).sort(function(linkA, linkB){
    var nameA = linkA.firstChild.nextSibling.innerText.toLowerCase();
    var nameB = linkB.firstChild.nextSibling.innerText.toLowerCase();
    if (nameA < nameB) {
      return -1;
    } if (nameA > nameB) {
      return 1;
    }
      return 0;
  });
  return sortedLinks;
}

function addSortedLinks(sortedLinks) {
  var links = $('.links');
  for(var i = 0; i < sortedLinks.length; i++) {
    links.append(sortedLinks[i]);
  }
}
