$(function() {
    $('[id^=heart-icon-main-]').click(function() {
        var arr = $(this).attr('id').split('-');
        var like_id = arr[4];
        var like_type = arr[3];
        // AJAX
        $.ajax({
            url:'/update_like',
            type:'POST',
            data:{
                'like_id' :like_id, 
                'like_type' :like_type,
            },
            dataType: 'json',
            async: true
        }).success( (data) => {
            var count = Number(data.result);
            if (count == 0) {
                $('#heart-on-' + like_type + '-' + like_id).hide();
                $('#heart-off-' + like_type + '-' + like_id).show();
                $('#heart-off-count-' + like_type + '-' + like_id).text(count);
            }
            if (count > 0) {
                $('#heart-off-' + like_type + '-' + like_id).hide();
                $('#heart-on-' + like_type + '-' + like_id).show().animate({top: -5}, 200).animate({top: 0}, 200);
                $('#heart-on-count-' + like_type + '-' + like_id).text(count);
            }
        }).fail( (data) => {
            console.log("AJAX FAILED.");
        });
    });
});
