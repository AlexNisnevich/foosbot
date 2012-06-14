$(document).ready(function(){
    $('.player select').change(function () {
        var $select = $(this);
        var id = $select.val();
        if (id == '') {
            $select.parent().css('background-image', '')
        } else {
            $.get('/players/' + id + '/photo', function (data) {
                $select.parent().css('background-image', 'url(' + data + ')');
            });
        }
    });

    $('.round_score').input(function () {
        var total = 0;
        $(this).parent().parent().find('.round_score').each(function (i, elt) {total += parseInt(elt.value);});
        $(this).parent().parent().find('.final_score').val(total);
    });
});