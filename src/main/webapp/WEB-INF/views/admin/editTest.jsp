<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit test</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
          rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.css"
          rel="stylesheet"/>
    <link href='https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css'
          rel='stylesheet' >

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <style>
        <%@ include file="../../styles/admin-tests-styles.css" %>
        <%@ include file="../../styles/admin-edit-test-styles.css" %>
        <%@ include file="../../styles/admin-modal-styles.css" %>
    </style>
</head>
<body class="bg-dark">

    <jsp:include page="/WEB-INF/views/templates/menuAdmin.jsp"/>

    <form id="updateTest" action="${pageContext.request.contextPath}/admin/tests/edit?action=updateTest&id=${requestScope.editingTest.id}" method="post">
        <table class="table table-bordered">
            <tbody id="editTest">
            <tr>
                <td>Subject:
                    <select name="subjectSelect" class="form-select m-b-15" aria-label="subject selecting">
                        <c:forEach var="subject" items="${sessionScope.subjectsList}">
                            <c:choose>
                                <c:when test="${subject.id == requestScope.editingTest.subject.id}">
                                    <option selected value="${subject.id}">${subject.name}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${subject.id}">${subject.name}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </td>
                <td>Title:
                    <div class="form-outline mb-3">
                        <input value="${requestScope.editingTest.title}" type="text" name="title" id="editTitle" class="form-control"/>
                    </div>
                </td>
                <td rowspan="2">Description:
                    <div class="form-outline mb-3">
                        <textarea rows="5" name="description" id="editDescription" class="form-control">${requestScope.editingTest.description}</textarea>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Difficulty:
                    <select name="difficultySelect" class="form-select m-b-15" aria-label="difficulty selecting">
                        <c:choose>
                            <c:when test="${requestScope.editingTest.difficulty.name().equals('EASY')}">
                                <option selected style="color: green" value="EASY">Easy</option>
                            </c:when>
                            <c:otherwise>
                                <option style="color: green" value="EASY">Easy</option>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${requestScope.editingTest.difficulty.name().equals('MEDIUM')}">
                                <option selected style="color: orange" value="MEDIUM">Medium</option>
                            </c:when>
                            <c:otherwise>
                                <option style="color: orange" value="MEDIUM">Medium</option>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${requestScope.editingTest.difficulty.name().equals('DIFFICULT')}">
                                <option selected style="color: red" value="DIFFICULT">Difficult</option>
                            </c:when>
                            <c:otherwise>
                                <option style="color: red" value="DIFFICULT">Difficult</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </td>
                <td>Time:
                    <div class="form-outline mb-3">
                        <input value="${requestScope.editingTest.time}" type="time" step="1" name="time" id="editTime" class="form-control"/>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="d-grid gap-2 col-3 mx-auto">
            <button class="btn btn-outline-success" type="submit">
                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
                    <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0z"></path>
                    <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l7-7z"></path>
                </svg>
                Update
            </button>
        </div>
    </form>

    <header class="header">
        <div class="header-title" style="margin-right: 70%">
            List of questions
        </div>
        <button data-bs-toggle="modal" data-bs-target="#modal-add-question"
                type="button" class="btn btn-success btn-rounded">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                 fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"></path>
            </svg>
        </button>
    </header>

    <c:if test="${not empty sessionScope.addedQuestion}">
        <c:choose>
            <c:when test="${sessionScope.addedQuestion == 'success'}">
                <script>
                    swal("Success", "You have successfully added a new question!", "success");
                </script>
            </c:when>
            <c:when test="${sessionScope.addedQuestion == 'empty'}">
                <script>
                    swal("Empty input", "Please fill in the required fields", "warning");
                </script>
            </c:when>
            <c:when test="${sessionScope.addedQuestion == 'failed'}">
                <script>
                    swal("Error", "You failed to add a new question!", "error");
                </script>
            </c:when>
        </c:choose>
        <c:remove var="addedQuestion" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.addedAnswer}">
        <c:choose>
            <c:when test="${sessionScope.addedAnswer == 'success'}">
                <script>
                    swal("Success", "You have successfully added a new answer!", "success");
                </script>
            </c:when>
            <c:when test="${sessionScope.addedAnswer == 'empty'}">
                <script>
                    swal("Empty input", "Please fill in the required fields", "warning");
                </script>
            </c:when>
            <c:when test="${sessionScope.addedAnswer == 'failed'}">
                <script>
                    swal("Error", "You failed to add a new answer!", "error");
                </script>
            </c:when>
        </c:choose>
        <c:remove var="addedAnswer" scope="session"/>
    </c:if>

    <main>
        <table class="table align-middle mb-0 bg-white">
            <thead class="bg-light">
            <tr>
                <th>№</th>
                <th>Question</th>
                <th>Count of answers</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="question" items="${requestScope.editingTest.questionsList}">
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img
                                    src="../../../images/question-icon.png"
                                    alt="question-icon"
                                    style="width: 45px; height: 45px"
                                    class="rounded-circle"
                            />
                            <div class="ms-3">
                                <b>№${requestScope.editingTest.questionsList.indexOf(question) + 1}</b>
                            </div>
                        </div>
                    </td>

                    <td class="col-5">

                        <form action="${pageContext.request.contextPath}/admin/tests/edit?action=updateQuestion&id=${requestScope.editingTest.id}&questionID=${question.id}"
                              method="post">

                            <label style="min-width: 100%; margin-top: 3%">
                                <input class="input_${question.id}" type="text" style="min-width: 90%;"
                                       name="newQuestion" value="${question.questionText}" disabled="disabled"/>
                                <input class="submit_${question.id} button-submit-edit-question" style="max-width: 10%;"
                                       type="submit" value="✓" hidden="hidden"/>
                            </label>

                        </form>
                    </td>

                    <td>
                        <div class="count-of-answers">
                             ${question.answersList.size()}
                        </div>
                    </td>

                    <td>
                        <button onclick="edit_question(${question.id})"
                                type="button" class="btn btn-link btn-sm btn-rounded">
                            Edit
                        </button>
                        <form action="${pageContext.request.contextPath}/admin/tests/delete?entity=question&entityID=${question.id}&testID=${requestScope.editingTest.id}"
                              method="post"
                              class="mb-0">
                            <button style="color: #e30000"
                                    type="submit"
                                    class="btn btn-link btn-rounded btn-sm fw-bold"
                                    data-mdb-ripple-color="dark"
                            >
                                Delete
                            </button>
                        </form>
                        <button onclick="dropdown_answers(${question.id});"
                                style="color: orange;" type="button" id="answers${question.id}" class="btn btn-link btn-sm btn-rounded">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square" viewBox="0 0 16 16">
                                <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0l-4-4.5z"></path>
                                <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V2z"></path>
                            </svg>
                            Answers
                        </button>
                    </td>
                </tr>

                <tr class="question_id${question.id} table-warning answer-row" hidden="hidden">
                    <th>№</th>
                    <th>Answer</th>
                    <th>Status</th>
                    <th>
                        Actions
                        <button data-bs-toggle="modal" data-bs-target="#modal-add-answer"
                                data-id="${question.id}"
                                type="submit" class="addAnswerButton btn btn-warning btn-rounded">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                 fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"></path>
                            </svg>
                        </button>
                    </th>
                </tr>
                <c:forEach var="answer" items="${question.answersList}">
                    <tr class="question_id${question.id} table-warning answer-row" hidden="hidden">
                        <td>
                            <div class="d-flex align-items-center">
                                <img    src="../../../images/answer-icon.png"
                                        alt="answer-icon"
                                        style="width: 45px; height: 45px"
                                        class="rounded-circle"
                                />
                                <div class="ms-3">
                                    <b>№${question.answersList.indexOf(answer) + 1}</b>
                                </div>
                            </div>
                        </td>

                        <form action="${pageContext.request.contextPath}/admin/tests/edit?action=updateAnswer&id=${requestScope.editingTest.id}&answerID=${answer.id}"
                              method="post">

                            <td class="col-5">
                                <label style="min-width: 100%;">
                                    <input class="answInput_${answer.id}" type="text" style="min-width: 90%"
                                           name="newAnswer" value="${answer.answerText}" disabled="disabled"/>
                                </label>
                            </td>

                            <td>
                                <div>
                                    <select name="newStatus" class="answInput_${answer.id} form-select"
                                            aria-label="answer-status-selecting" disabled="disabled"
                                            style="max-width: 80%;">
                                        <c:choose>
                                            <c:when test="${answer.answerStatus.name().equals('RIGHT')}">
                                                <option selected style="color: green" value="RIGHT">Right</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option style="color: green" value="RIGHT">Right</option>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:choose>
                                            <c:when test="${answer.answerStatus.name().equals('WRONG')}">
                                                <option selected style="color: red" value="WRONG">Wrong</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option style="color: red" value="WRONG">Wrong</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                            </td>

                        <td style="padding: 5px">
                            <button onclick="edit_answer(${answer.id})"
                                    type="button" class="btn btn-link btn-sm btn-rounded">
                                Edit
                            </button>

                            <input class="answSubmit_${answer.id} button-submit-edit-question" style="max-width: 10%;"
                                   type="submit" value="✓" hidden="hidden"/>
                        </form>

                            <form action="${pageContext.request.contextPath}/admin/tests/delete?entity=answer&entityID=${answer.id}&testID=${requestScope.editingTest.id}"
                                  method="post"
                                  class="mb-0">
                                <button style="color: #e30000"
                                        type="submit"
                                        class="btn btn-link btn-rounded btn-sm fw-bold"
                                        data-mdb-ripple-color="dark"
                                >
                                    Delete
                                </button>
                            </form>

                        </td>
                    </tr>
                </c:forEach>

            </c:forEach>
            </tbody>
        </table>
    </main>

    <footer class="footer">
        <jsp:include page="../templates/footer.jsp"/>
    </footer>

    <!----------------------------------Students modal window---------------------------------->

    <div class="modal fade" id="modal-add-question" tabindex="-1" aria-labelledby="modal-add-question-label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modalWindow">
                <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                <div class="modal-addTest col-lg-5" style="border-radius: 25px; border: 2px #219d35 solid">
                    <div class="card-body p-md-3 mx-md-5">

                        <div class="text-center">
                            <h4 class="mt-1 mb-4">Adding new question</h4>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/tests/edit?action=addQuestion&id=${requestScope.editingTest.id}" method="post">
                            <div class="form-outline mb-3">
                                <textarea rows="6" name="question" class="form-control"></textarea>
                            </div>

                            <div class="text-center pt-1">
                                <button class="btn btn-primary btn-block fa-lg mb-2 text-black"
                                        style="background-color: #ababab; border: 1px grey solid" type="reset">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eraser-fill" viewBox="0 0 16 16">
                                        <path d="M8.086 2.207a2 2 0 0 1 2.828 0l3.879 3.879a2 2 0 0 1 0 2.828l-5.5 5.5A2 2 0 0 1 7.879 15H5.12a2 2 0 0 1-1.414-.586l-2.5-2.5a2 2 0 0 1 0-2.828l6.879-6.879zm.66 11.34L3.453 8.254 1.914 9.793a1 1 0 0 0 0 1.414l2.5 2.5a1 1 0 0 0 .707.293H7.88a1 1 0 0 0 .707-.293l.16-.16z"></path>
                                    </svg>
                                    Reset
                                </button>
                            </div>
                            <div class="text-center mb-4">
                                <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                        style="background-color: #219d35; border: 1px grey solid" type="submit">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                         fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"></path>
                                    </svg>
                                    Add
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-add-answer" tabindex="-1" aria-labelledby="modal-add-answer-label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modalWindow">
                <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                <div class="modal-addTest col-lg-5" style="border-radius: 25px; border: 2px #f29263 solid">
                    <div class="card-body p-md-3 mx-md-5">

                        <div class="text-center">
                            <h4 class="mt-1 mb-4">Adding new answer</h4>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/tests/edit?action=addAnswer&id=${requestScope.editingTest.id}"
                              method="post">

                            <input type="text" name="questionID" id="questionID" value="" hidden="hidden">

                            <div class="form-outline mb-3">
                                <textarea rows="5" name="answerText" class="form-control"></textarea>
                            </div>

                            <select name="answerStatusSelect" class="form-select m-b-15" aria-label="status selecting">
                                <option selected>Status</option>
                                <option style="color: green" value="RIGHT">Right</option>
                                <option style="color: red" value="WRONG">Wrong</option>
                            </select>

                            <div class="text-center pt-1">
                                <button class="btn btn-primary btn-block fa-lg mb-2 text-black"
                                        style="background-color: #ababab; border: 1px grey solid" type="reset">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eraser-fill" viewBox="0 0 16 16">
                                        <path d="M8.086 2.207a2 2 0 0 1 2.828 0l3.879 3.879a2 2 0 0 1 0 2.828l-5.5 5.5A2 2 0 0 1 7.879 15H5.12a2 2 0 0 1-1.414-.586l-2.5-2.5a2 2 0 0 1 0-2.828l6.879-6.879zm.66 11.34L3.453 8.254 1.914 9.793a1 1 0 0 0 0 1.414l2.5 2.5a1 1 0 0 0 .707.293H7.88a1 1 0 0 0 .707-.293l.16-.16z"></path>
                                    </svg>
                                    Reset
                                </button>
                            </div>
                            <div class="text-center mb-4">
                                <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                        style="background-color: #f29263; border: 1px grey solid" type="submit">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                         fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"></path>
                                    </svg>
                                    Add
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!----------------------------------------------------------------------------------------->

    <%--scripts--%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.js"
    ></script>
    <script>
        <%@ include file="../../scripts/edit-question-script.js" %>
        <%@ include file="../../scripts/edit-answer-script.js" %>

        setQuestionIdOnClickAddAnswerButton();
    </script>
    <c:if test="${not empty sessionScope.selectedQuestionID}">
        <script>
            document.querySelector('#answers${sessionScope.selectedQuestionID}').click();
        </script>
        <c:remove var="selectedQuestionID" scope="session"/>
    </c:if>

</body>
</html>