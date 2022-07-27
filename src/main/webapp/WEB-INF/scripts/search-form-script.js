function searchFunction(column) {
    // Declare variables
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchForm");
    filter = input.value.toUpperCase();
    table = document.getElementById("main-table");
    tr = table.getElementsByTagName("tr");

    var columnIndex;
    switch (column) {
        case 'titles':  columnIndex = 1; break;
        case 'names': columnIndex = 0; break;
        case 'question': columnIndex = 1; break;
    }
    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[columnIndex];
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}