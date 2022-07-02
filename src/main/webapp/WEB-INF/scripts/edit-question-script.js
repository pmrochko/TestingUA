function edit_question(question_id) {
    let input = document.querySelectorAll('.input_' + question_id);
    let submit = document.querySelectorAll('.submit_' + question_id);

    input.forEach((elem) => {
        if (elem.hasAttribute('disabled'))
            elem.removeAttribute('disabled');
        else elem.setAttribute('disabled', 'disabled')
    });

    submit.forEach((elem) => {
        if (elem.hasAttribute('hidden'))
            elem.removeAttribute('hidden');
        else elem.setAttribute('hidden', 'hidden')
    });
}

function dropdown_answers(question_id) {
    let answersRows = document.querySelectorAll('.question_id' + question_id);

    answersRows.forEach((elem) => {
        if (elem.hasAttribute('hidden'))
            elem.removeAttribute('hidden');
        else elem.setAttribute('hidden', 'hidden')
    });
}

function setQuestionID(question_id) {

    document.createAttribute('sessionScope')

}