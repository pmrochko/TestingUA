<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Process</title>

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
        <%@ include file="../../styles/student-tests-styles.css" %>
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/templates/menuStudent.jsp"/>

    <!----------------------------------Students modal window---------------------------------->



    <!----------------------------------------------------------------------------------------->

    <header class="header">
        <div class="header-title">
            Answer the question:
        </div>
        <div class="timer">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-stopwatch" viewBox="0 0 16 16">
                <path d="M8.5 5.6a.5.5 0 1 0-1 0v2.9h-3a.5.5 0 0 0 0 1H8a.5.5 0 0 0 .5-.5V5.6z"></path>
                <path d="M6.5 1A.5.5 0 0 1 7 .5h2a.5.5 0 0 1 0 1v.57c1.36.196 2.594.78 3.584 1.64a.715.715 0 0 1 .012-.013l.354-.354-.354-.353a.5.5 0 0 1 .707-.708l1.414 1.415a.5.5 0 1 1-.707.707l-.353-.354-.354.354a.512.512 0 0 1-.013.012A7 7 0 1 1 7 2.071V1.5a.5.5 0 0 1-.5-.5zM8 3a6 6 0 1 0 .001 12A6 6 0 0 0 8 3z"></path>
            </svg>
            <c:choose>
                <c:when test="${sessionScope.startedTest.time == 0.0}">
                    <b id="countdownTimer">Timer: <span style="color: #29c000">UNLIM</span></b>
                </c:when>
                <c:otherwise>
                    <b id="countdownTimer">Timer: <span id="timer" style="color: #e30000"></span></b>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <main>
        <div class="test">

            <div class="test-title bg-dark">
                <h3>${sessionScope.startedTest.title}</h3>
            </div>

            <form action="${pageContext.request.contextPath}/student/tests/result" method="post">

                <c:forEach var="question" items="${sessionScope.startedTest.questionsList}">

                    <div class="test-question bg-dark">

                        <h5 class="mb-3">${question.questionText}</h5>

                        <c:choose>
                            <c:when test="${question.questionStatus.name().equals('SIMPLE')}">
                                <c:forEach var="answer" items="${question.answersList}">
                                    <div class="form-answer form-check mb-2">
                                        <input value="${answer.id}" class="form-check-input" type="radio" name="answ${question.id}" id="${answer.id}"/>
                                        <label class="form-check-label" for="${answer.id}">${answer.answerText}</label>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:when test="${question.questionStatus.name().equals('COMPLEX')}">
                                <c:forEach var="answer" items="${question.answersList}">
                                    <div class="form-answer form-check mb-2">
                                        <input value="${answer.id}" class="form-check-input" type="checkbox" name="answ${question.id}_${answer.id}" id="${answer.id}"/>
                                        <label class="form-check-label" for="${answer.id}">${answer.answerText}</label>
                                    </div>
                                </c:forEach>
                            </c:when>
                        </c:choose>

                    </div>

                    <hr>

                </c:forEach>

                <label hidden="hidden">
                    <input name="time" value="" id="timeInputInForm" hidden="hidden">
                </label>

                <div class="d-grid gap-2 col-6 mx-auto">
                    <button id="submit" type="submit" class="btn btn-success">Submit</button>
                </div>

            </form>

        </div>
    </main>

    <footer class="footer">
        <jsp:include page="../templates/footer.jsp"/>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.js"
    ></script>

    <c:if test="${sessionScope.startedTest.time != 0.0}">
        <script>
            <%@ include file="../../scripts/timer-script.js" %>
            setTimer(${sessionScope.startedTest.time})
        </script>
    </c:if>

</body>
</html>