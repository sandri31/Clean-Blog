document.addEventListener("DOMContentLoaded", function () {
    var searchInput = document.querySelector("#title_search");
    if (searchInput) {
        searchInput.addEventListener("input", function () {
            this.form.requestSubmit();
        });
    }
});