<%@ include file="../templates/libsAndLocale.jspf" %>
<%@ taglib uri="/WEB-INF/tlds/currentDate.tld" prefix="d" %>

<html>
<head>
    <title>
        <fmt:message key="student.historyPage"/>
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
        <div class="header-date">
            <d:currentDate>
                <fmt:message key="date.now"/>:
            </d:currentDate>
        </div>
        <div class="header-title">
            <fmt:message key="student.historyPage.headerTitle"/>
        </div>
        <div class="input-group search">
            <div class="form-outline">
                <input type="search" id="searchForm" class="form-control bg-dark" onkeyup="searchFunction('titles')"/>
                <label class="form-label" for="searchForm"><fmt:message key="search.byTitle"/></label>
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
                <my:columnTitle index="0" name="test.subject"/>
                <my:columnTitle index="1" name="test.title"/>
                <my:columnTitle index="2" name="test.difficulty"/>
                <my:columnTitle index="3" name="test.dateAndTime"/>
                <my:columnTitle index="4" name="test.result"/>
                <my:columnTitle index="5" name="test.status"/>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="historyRecord" items="${requestScope.historyOfTests}">
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img
                                    src="../../../images/history-icon.png"
                                    alt="test-icon"
                                    style="width: 45px; height: 45px"
                                    class="rounded-circle"
                            />
                            <div class="ms-3">
                                <b>
                                    <fmt:message key="subject.${historyRecord.test.subject.name}"/>
                                </b>
                            </div>
                        </div>
                    </td>

                    <td>
                         ${historyRecord.test.title}
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${historyRecord.test.difficulty.name() == 'EASY'}">
                                <span class="badge badge-success rounded-pill d-inline">
                                    <fmt:message key="test.difficulty.easy"/>
                                </span>
                            </c:when>
                            <c:when test="${historyRecord.test.difficulty.name() == 'MEDIUM'}">
                                <span class="badge badge-warning rounded-pill d-inline">
                                    <fmt:message key="test.difficulty.medium"/>
                                </span>
                            </c:when>
                            <c:when test="${historyRecord.test.difficulty.name() == 'DIFFICULT'}">
                                <span class="badge badge-danger rounded-pill d-inline">
                                    <fmt:message key="test.difficulty.difficult"/>
                                </span>
                            </c:when>
                        </c:choose>
                    </td>

                    <td>
                        <p style="padding-left: 10px" class="mb-1">${historyRecord.date}</p>
                        <p style="padding-left: 18px" class="mb-0">${historyRecord.time}</p>
                    </td>

                    <td>
                        ${historyRecord.result}%
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${historyRecord.status.name() == 'STARTED'}">
                                <span class="badge badge-warning rounded-pill d-inline">
                                    <fmt:message key="test.status.started"/>
                                </span>
                            </c:when>
                            <c:when test="${historyRecord.status.name() == 'TIMEOUT'}">
                                <span class="badge badge-danger rounded-pill d-inline">
                                    <fmt:message key="test.status.timeout"/>
                                </span>
                            </c:when>
                            <c:when test="${historyRecord.status.name() == 'FINISHED'}">
                                <span class="badge badge-success rounded-pill d-inline">
                                    <fmt:message key="test.status.finished"/>
                                </span>
                            </c:when>
                        </c:choose>
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
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