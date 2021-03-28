$(function() {
    $('[id^=heart-icon-main-]').click(function() {
        var arr = $(this).attr('id').split('-');
        var like_id = arr[4];
        var like_type = arr[3];
        // AJAX
        $.ajax({
            url:'./update_like',
            type:'POST',
            data:{
                'like_id' :like_id, 
                'like_type' :like_type,
            },
            dataType: 'json',
            async: true
        }).success( (data) => {
            var count = Number(data.count);
            if (count == 0) {
                $('#heart-on-' + like_type + '-' + like_id).hide();
                $('#heart-off-' + like_type + '-' + like_id).show();
                $('#heart-off-count-' + like_type + '-' + like_id).text(count);
                $('#heart-icon-main-' + like_type + '-' + like_id).removeClass('like-sender-tooltip');
                $('#heart-senders-' + like_type + '-' + like_id).html('');
            }
            if (count > 0) {
                $('#heart-off-' + like_type + '-' + like_id).hide();
                $('#heart-on-' + like_type + '-' + like_id).show();
                $('#heart-on-count-' + like_type + '-' + like_id).text(count);
                $('#heart-icon-main-' + like_type + '-' + like_id).addClass('like-sender-tooltip');
                $('#heart-senders-' + like_type + '-' + like_id).html(data.senders);
            }
        }).fail( (data) => {
            console.log("AJAX FAILED.");
        });
    });

    // Resolved an issue with duplicate icons in version 4.1

    if ($('#tab-properties').attr('class') == 'selected') {
        $('[id^=heart-icon-main-]').hide();
    }

    $('#tab-history').click(function() {
        $('[id^=heart-icon-main-]').hide();
    });

    $('#tab-notes').click(function() {
        $('[id^=heart-icon-main-]').show();
    });

    $('#tab-properties').click(function() {
        $('[id^=heart-icon-main-]').hide();
    });

    $('#tab-time_entries').click(function() {
        $('[id^=heart-icon-main-]').hide();
    });

    $('#tab-changesets').click(function() {
        $('[id^=heart-icon-main-]').hide();
    });
});
