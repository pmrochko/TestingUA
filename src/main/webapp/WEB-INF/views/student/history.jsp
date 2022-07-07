<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>History</title>

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
        History of your tests
    </div>
    <div class="input-group search">
        <div class="form-outline">
            <input type="search" id="searchForm" class="form-control" />
            <label class="form-label" for="searchForm">Search</label>
        </div>
        <button type="button" class="btn btn-primary">
            <i class="fas fa-search"></i>
        </button>
    </div>
</header>

<main>
    <table class="table align-middle mb-0 bg-white">
        <thead class="bg-light">
        <tr>
            <th>Subject</th>
            <th>Title</th>
            <th>Difficulty</th>
            <th>Data and Time</th>
            <th>Result(%)</th>
            <th>Status</th>
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
                            <b>${historyRecord.test.subject.name}</b>
                        </div>
                    </div>
                </td>

                <td>
                     ${historyRecord.test.title}
                </td>

                <td>
                    <c:choose>
                        <c:when test="${historyRecord.test.difficulty.name() == 'EASY'}">
                            <span class="badge badge-success rounded-pill d-inline">EASY</span>
                        </c:when>
                        <c:when test="${historyRecord.test.difficulty.name() == 'MEDIUM'}">
                            <span class="badge badge-warning rounded-pill d-inline">MEDIUM</span>
                        </c:when>
                        <c:when test="${historyRecord.test.difficulty.name() == 'DIFFICULT'}">
                            <span class="badge badge-danger rounded-pill d-inline">DIFFICULT</span>
                        </c:when>
                    </c:choose>
                </td>

                <td>
                    ${historyRecord.dateTime}
                </td>

                <td>
                    ${historyRecord.result}%
                </td>

                <td>
                    <c:choose>
                        <c:when test="${historyRecord.status.name() == 'STARTED'}">
                            <span class="badge badge-warning rounded-pill d-inline">STARTED</span>
                        </c:when>
                        <c:when test="${historyRecord.status.name() == 'TIMEOUT'}">
                            <span class="badge badge-danger rounded-pill d-inline">TIMEOUT</span>
                        </c:when>
                        <c:when test="${historyRecord.status.name() == 'FINISHED'}">
                            <span class="badge badge-success rounded-pill d-inline">FINISHED</span>
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
</body>
</html>