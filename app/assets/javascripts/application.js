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
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .


$(window).on('load',function(){
  $('.select_scope_style').on('click', function(){
    $('.select_scope_back').show();
    $('.select_scope').show();
  });
  $('.select_scope_back').on('click', function(){
    $('.select_scope_back').hide();
    $('.select_scope').hide();
  });
  $('.select_scope_back_button').on('click', function(){
    $('.select_scope_back').hide();
    $('.select_scope').hide();
  });
});
