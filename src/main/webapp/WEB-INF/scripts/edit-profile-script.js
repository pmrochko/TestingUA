let inputBoxes = document.querySelectorAll('.edit-profile-box');
let inputForms = document.querySelectorAll('.edit-form');

function trigger_show() {
    inputForms.forEach((element1) => {
        if (element1.classList.contains('edit-fade')) element1.classList.remove('edit-fade');
        else element1.classList.add('edit-fade');
    });
    inputBoxes.forEach((element2) => {
        if (element2.style.display === 'none') element2.style.display = 'block';
        else element2.style.display = 'none';
    });
}