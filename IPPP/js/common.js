function closepopup() {
    $('#myModal').modal('hide')
}


$(document).ready(function () {
    var message = $("[id$=hdnMsg]").val()
    $("[id$=hdnMsg]").val('')
    if (message != undefined && message.trim() != '') {
        $("#lblMessage").text(message)
        $('#myModal').modal('show')
    }

});

