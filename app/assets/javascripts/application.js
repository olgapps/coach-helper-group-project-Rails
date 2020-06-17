// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require bootstrap-sprockets
//= require moment
// If you require timezone data (see moment-timezone-rails for additional file options)
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4

$(document).ready(function() {
  $("alert.alert-success").fadeOut(3000);
});

jQuery(document).ready(function() {
  jQuery(".active").click(function() {
    setTimeout(() => {
      const id = $(this).data("target-cent-id");
      var viewportWidth = jQuery(window).width(),
        viewportHeight = jQuery(window).height(),
        $foo = jQuery(".cent[data-cent-id='" + id + "'].collapse.show"),
        elWidth = $foo.width(),
        elHeight = $foo.height(),
        elOffset = $foo.offset();
      jQuery(window)
        .scrollTop(elOffset.top + elHeight / 2 - viewportHeight / 2)
        .scrollLeft(elOffset.left + elWidth / 2 - viewportWidth / 2);
    }, 400);
  });
});
