$(function () {
    ShowHideButton();
});
$('input[type=radio][name$=rblConfirm]').live('click', ShowHideButton);
function ShowHideButton() {
    var rblConfirm = $('input[type=radio][name$=rblConfirm]:checked').val()
    var btnSubmit = $('[id$=btnSubmit]');
    var pnlEdit = $('[id$=pnlEdit]');
    if (rblConfirm == undefined) {
        btnSubmit.hide();
        pnlEdit.hide();
    }
    else {
        btnSubmit.show();
        if (rblConfirm == "false") {
            pnlEdit.show();
        }
        else {
            pnlEdit.hide();
        }
    }
}