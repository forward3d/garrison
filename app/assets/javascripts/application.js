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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery/dist/jquery
//= require moment/moment
//= require popper.js/dist/umd/popper
//= require bootstrap/dist/js/bootstrap
//= require @fortawesome/fontawesome
//= require @fortawesome/fontawesome-free-regular
//= require @fortawesome/fontawesome-free-solid
//= require @fortawesome/fontawesome-free-brands
//= require chart.js/dist/Chart
//= require jmespath/jmespath
//= require_tree .

$(document).ready(function() {

  $(document).on('click', function(e) {
    $('[data-toggle="popover"]').each(function() {
      if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
        $(this).popover('hide')
      }
    });
  });

  $(".editable").each(function() {
    var popover = $(this).popover({
      container: 'body',
      html: true,
      content: 'Loading...'
    }).on('show.bs.popover', function () {
      setTimeout(function(){
        $('.popover').data('id', popover.data('id'));
        $('.popover').data('path', popover.data('path'));
      }, 0);

      $.ajax({
        dataType: 'html',
        cache: false,
        url: '/alerts/' + popover.data('uuid') + '/edit?field=' + popover.data('field'),
        success: function (html) {
          $('.popover-body').html(html);
          $('.popover-body').find('.form-control').focus();

          // bootstrap popovers really don't like dynamic content, this is to
          // make sure it ends up in the right place
          setTimeout(function(){
            $('.popover').popover('update');
          }, 0);
        }
      });
    });
  });

})
