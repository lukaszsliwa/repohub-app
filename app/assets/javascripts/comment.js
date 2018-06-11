$(document).ready(function() {
    $('.line').click(function() {
        $(this).parents('tr').toggleClass('line-selected');
        var line_id = $(this).parents('tr').data('id');
        $('tr.comments-' + line_id).toggleClass('hidden');
    });

    $('.collapse-comments').click(function() {
        var comments = $(this).parents('.file').find('tr.comments');
        console.log(comments.length);
        if ($(this).data('collapse') == 'on') {
            $.each(comments, function(index, item) {
                if ($(item).data('comments-count') > 0) {
                    $(item).addClass('hidden');
                }
            });
            $(this).data('collapse', 'off');
        } else {
            $.each(comments, function(index, item) {
                if ($(item).data('comments-count') > 0) {
                    $(item).removeClass('hidden');
                }
            });
            $(this).data('collapse', 'on');
        }
        return false;
    });
});