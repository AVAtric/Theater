$('#arbeiterModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var svnr = button.data('svnr');
    var vorname = button.data('vorname');
    var nachname = button.data('nachname');
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this);
    modal.find('.modal-title').text(vorname + ' ' + nachname + " (" + svnr + ")");
    modal.find('.modal-body input#svnr').val(svnr);
    modal.find('.modal-body input#vorname').val(vorname);
    modal.find('.modal-body input#nachname').val(nachname);
});

$('#submitEditArbeiter').click(function () {
    $('#arbeiterEditForm').submit();
});

$('#deleteModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var svnr = button.data('svnr');
    var vorname = button.data('vorname');
    var nachname = button.data('nachname');
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this);
    modal.find('.modal-title').text(vorname + ' ' + nachname + " (" + svnr + ")");
    modal.find('.modal-body input#svnrDel').val(svnr);
});


$('#submitDeleteArbeiter').click(function () {
    $('#arbeiterDeleteForm').submit();
});

$('#submitInsertArbeiter').click(function () {
    $('#arbeiterInsertForm').submit();
});

