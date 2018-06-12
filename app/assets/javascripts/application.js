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
//= require bootstrap-select/dist/js/bootstrap-select
//= require @fortawesome/fontawesome
//= require @fortawesome/fontawesome-free-regular
//= require @fortawesome/fontawesome-free-solid
//= require @fortawesome/fontawesome-free-brands
//= require chart.js/dist/Chart
//= require jmespath/jmespath
//= require_tree .

document.addEventListener('turbolinks:load', function() {

  // bootstrap-select turbolinks support
  $('.selectpicker').each(function (i, el) {
    if (!$(el).parent().hasClass('bootstrap-select')) {
      $(el).selectpicker('refresh');
    }
  });

  // fontawesome turbolinks support
  FontAwesome.dom.i2svg();
  $('body').on('ajax:success', function(event) {
    FontAwesome.dom.i2svg();
  })

  // close all other popovers when another one is opened
  $(document).on('click', function(e) {
    $('[data-toggle="popover"]').each(function() {
      if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
        $(this).popover('hide')
      }
    });
  });

  // in-place editing
  $('body').popover({
    container: 'body',
    html: true,
    selector: 'a.editable',
    content: 'Loading...'
  })

  $('body').on('show.bs.popover', 'a.editable', function() {
    var popover = $(this).data('bs.popover')
    $(popover.tip).data('element', $(this).data('element'))

    $.ajax({
      dataType: 'html',
      cache: false,
      url: '/alerts/' + $(this).data('uuid') + '/edit?field=' + $(this).data('field'),
      success: function (html) {
        $(popover.tip).find('.popover-body').html(html);
        $(popover.tip).find('.form-control').focus();

        // bootstrap popovers really don't like dynamic content, this is to
        // make sure it ends up in the right place
        setTimeout(function(){
          popover._popper.scheduleUpdate()
        }, 0);
      }
    });
  });

  $('body').on('ajax:error', 'form.editable', function(event) {
    var popover = $(this).closest('.popover')

    setTimeout(function(){
      popover.find('button').removeClass("btn-warning").addClass("btn-danger");
      popover.find('button').html('<i class="fas fa-times"></i>');
      popover.find('button').prop('disabled', true);
    }, 0);
  })

  $('body').on('ajax:success', 'form.editable', function(event) {
    var popover = $(this).closest('.popover')
    var editable = $('a.editable[data-element="' + popover.data('element') + '"]')
    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];

    setTimeout(function(){
      popover.find('button').removeClass("btn-warning").addClass("btn-success");
      popover.find('button').html('<i class="fas fa-check"></i>');
      popover.find('button').prop('disabled', true);

      text = jmespath.search(data, editable.data('path'))
      if ($.isArray(text)) {
        text = text.join(', ');
      }

      if (text == "") {
        editable.text('Empty')
        editable.addClass('editable-empty')
      } else {
        editable.text(text);
        editable.removeClass('editable-empty')
      }
    }, 0);

    setTimeout(function(){
      popover.popover('hide');
    }, 1000);
  });

})
