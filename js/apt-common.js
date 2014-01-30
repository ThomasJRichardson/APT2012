function apt() {
    //Emtpy function for use with jQuery
}

function showDisclaimer() {
    $("#DisclaimerDialog").dialog({
        title: "Agreement",
        modal: true,
        bgiframe: true,
        width: 600,
        height: 375,
        closeOnEscape: false,
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close").hide();
            $('.ui-dialog-buttonpane').find('button:contains("Reject")').addClass('rejectButtonClass');
            $('.ui-dialog-buttonpane').find('button:contains("Accept")').addClass('acceptButtonClass');
            $('.ui-dialog-buttonpane').find('button:contains("Accept")').attr("disabled", "disabled"); 
             
        },
        buttons: { "Reject": function () { rejectDisclaimer(); },
            "Accept": function () { hideDisclaimer(); }
        }
    });
    $("#DisclaimerDialog").dialog('open');
}

function hideDisclaimer() {
    $("#DisclaimerDialog").dialog('close');
}

function rejectDisclaimer() {
    history.go(-1);
}


