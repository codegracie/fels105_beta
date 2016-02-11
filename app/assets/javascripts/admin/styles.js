$("#menu-toggle").click(function(e) {
  e.preventDefault();
  $("#wrapper").toggleClass("toggled");
});

function remove_fields(link) {
  $(link).parent().children('.removable')[0].value = 1;
  $(link).parent().parent().hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(".added-answer").append(content.replace(regexp, new_id));
}