<%@ include file="../templates/libsAndLocale.jspf" %>

<html>
<head>
    <title>
        <fmt:message key="admin.testsPage"/>
    </title>

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
<body class="bg-dark">

    <jsp:include page="/WEB-INF/views/templates/menuStudent.jsp"/>

    <header class="header">

        <h5><fmt:message key="subject"/>:</h5>

        <div class="header-select-subject">
            <form action="${pageContext.request.contextPath}/student/tests">
                <select name="selectedSubject" onchange="this.form.submit()"
                        class="form-select bg-dark" aria-label="subject selection" style="color: #d0d0d0;">
                    <option value="All"><fmt:message key="subject.all"/></option>
                    <c:forEach var="subject" items="${sessionScope.subjectsList}">
                        <c:choose>
                            <c:when test="${sessionScope.selectedSubject.equals(subject.name)}">
                                <option selected value="${subject.name}">
                                    <fmt:message key="subject.${subject.name}"/>
                                </option>
                            </c:when>
                            <c:otherwise>
                                <option value="${subject.name}">
                                    <fmt:message key="subject.${subject.name}"/>
                                </option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </form>
        </div>

        <div class="header-select-sort">
            <form action="${pageContext.request.contextPath}/student/tests">
                <select name="selectedSort" onchange="this.form.submit()"
                        class="form-select bg-dark" aria-label="table sort" style="color: #d0d0d0;">
                    <option><fmt:message key="sort.by"/>:</option>
                    <optgroup label="<fmt:message key="subject"/>">
                        <option value="subjectUp"><fmt:message key="sort.alphabet.up"/></option>
                        <option value="subjectDown"><fmt:message key="sort.alphabet.down"/></option>
                    </optgroup>
                    <optgroup label="<fmt:message key="test.title"/>">
                        <option value=titleUp><fmt:message key="sort.alphabet.up"/></option>
                        <option value="titleDown"><fmt:message key="sort.alphabet.down"/></option>
                    </optgroup>
                    <optgroup label="<fmt:message key="test.difficulty"/>">
                        <option value="difficultyUp"><fmt:message key="sort.alphabet.up"/></option>
                        <option value="difficultyDown"><fmt:message key="sort.alphabet.down"/></option>
                    </optgroup>
                    <optgroup label="<fmt:message key="test.questions"/>">
                        <option value="questionUp"><fmt:message key="sort.numerical.up"/></option>
                        <option value="questionDown"><fmt:message key="sort.numerical.down"/></option>
                    </optgroup>
                    <optgroup label="<fmt:message key="test.time"/>">
                        <option value="timeUp"><fmt:message key="sort.numerical.up"/></option>
                        <option value="timeDown"><fmt:message key="sort.numerical.down"/></option>
                    </optgroup>
                </select>
            </form>
        </div>

        <div class="input-group search">
            <div class="form-outline">
                <input type="search" id="searchForm" class="form-control bg-dark" onkeyup="searchFunction('titles')"/>
                <label class="form-label" for="searchForm">
                    <fmt:message key="search.byTitle"/>
                </label>
            </div>
            <button type="button" class="btn btn-primary">
                <i class="fas fa-search"></i>
            </button>
        </div>

    </header>

    <main>
        <table id="main-table" class="table align-middle mb-0 bg-white">
            <thead class="bg-light">
            <tr>
                <th><fmt:message key="test.subject"/></th>
                <th><fmt:message key="test.title"/></th>
                <th><fmt:message key="test.difficulty"/></th>
                <th><fmt:message key="test.questions"/></th>
                <th><fmt:message key="test.time"/></th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="test" items="${requestScope.testsList}">
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img
                                    src="../../../images/test-icon.png"
                                    alt="test-icon"
                                    style="width: 45px; height: 45px"
                                    class="rounded-circle"
                            />
                            <div class="ms-3">
                                <b>
                                    <fmt:message key="subject.${test.subject.name}"/>
                                </b>
                            </div>
                        </div>
                    </td>

                    <td>
                        ${test.title}
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${test.difficulty.name() == 'EASY'}">
                                <span class="badge badge-success rounded-pill d-inline">
                                    <fmt:message key="test.difficulty.easy"/>
                                </span>
                            </c:when>
                            <c:when test="${test.difficulty.name() == 'MEDIUM'}">
                                <span class="badge badge-warning rounded-pill d-inline">
                                    <fmt:message key="test.difficulty.medium"/>
                                </span>
                            </c:when>
                            <c:when test="${test.difficulty.name() == 'DIFFICULT'}">
                                <span class="badge badge-danger rounded-pill d-inline">
                                    <fmt:message key="test.difficulty.difficult"/>
                                </span>
                            </c:when>
                        </c:choose>
                    </td>

                    <td>
                        ${test.questionsList.size()}
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${test.time == '00:00:00'}">
                                <span style="color:#29c000; font-size: 30px; padding-left: 15px;">∞</span>
                            </c:when>
                            <c:otherwise>
                                ${test.time}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${sessionScope.currentUser.historyContainRecordedTest(test) == true}">
                                <button onclick="document.location='/students/tests/start?id=${test.id}'"
                                        type="button" class="btn btn-success btn-sm btn-rounded">
                                    <fmt:message key="test.tryAgain"/>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button onclick="document.location='/students/tests/start?id=${test.id}'"
                                        type="button" class="btn btn-warning btn-sm btn-rounded">
                                    <fmt:message key="test.start"/>
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <nav class="pagination-nav" aria-label="Page navigation example">
            <ul class="pagination">

                <c:if test="${requestScope.currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="http://localhost:8080/student/tests?page=${requestScope.currentPage-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                </c:if>

                <c:forEach begin="1" end="${requestScope.totalCountOfPages}" var="page">
                    <li class="page-item"><a class="page-link" href="http://localhost:8080/student/tests?page=${page}">${page}</a></li>
                </c:forEach>

                <c:if test="${requestScope.currentPage < requestScope.totalCountOfPages}">
                    <li class="page-item">
                        <a class="page-link" href="http://localhost:8080/student/tests?page=${requestScope.currentPage+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </c:if>

            </ul>
        </nav>
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
    <script>
        <%@ include file="../../scripts/sorting-table-script.js" %>
        <%@ include file="../../scripts/search-form-script.js" %>
    </script>

</body>
</html>