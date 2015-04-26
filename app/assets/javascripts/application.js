// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require highlight/highlight.pack
//= require d3.min
//= require moment-with-locales.min
//= require_tree .

$(document).ready(function() {
    $('.line-code').each(function(i, block) {
        hljs.highlightBlock(block);
    });

    $('a.btn-diff').click(function() {
        $('#file-' + $(this).data('file-id') + ' .diff-wrapper').show();
        $('#file-' + $(this).data('file-id') + ' .file-wrapper').hide();
        $('#file-' + $(this).data('file-id') + ' .file-header-actions a.btn-view').removeClass('active');

        $(this).addClass('active');
        return false;
    });
});