function edit_answer(answer_id) {
    let input = document.querySelectorAll('.answInput_' + answer_id);
    let submit = document.querySelectorAll('.answSubmit_' + answer_id);

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

function setQuestionIdOnClickAddAnswerButton() {
    $(document).on("click", ".addAnswerButton", function () {
        var questionID = $(this).data('id');
        $("#questionID").val(questionID);
    });
}