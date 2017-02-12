function goToContacts(data) {
    var dataStr = JSON.stringify(data);
    $('.location').html("Contacts");
    $('.content')
        .removeClass('hidden')
        .html(dataStr);
}

function loadContacts() {
    $.getJSON("/get-users", function (data) {
        goToContacts(data);
    })
        .fail(function() {
            alert("Could not load contacts" );
        })
}