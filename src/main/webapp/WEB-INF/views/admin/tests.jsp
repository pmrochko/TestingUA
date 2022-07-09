<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Tests</title>

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
        <%@ include file="../../styles/admin-modal-styles.css" %>
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/templates/menuAdmin.jsp"/>

    <!----------------------------------Students modal window---------------------------------->

    <div class="modal fade" id="modal-add-test" tabindex="-1" aria-labelledby="modal-add-test-label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modalWindow">
                <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                <div class="modal-addTest col-lg-5" style="border-radius: 25px; border: 2px #219d35 solid">
                    <div class="card-body p-md-3 mx-md-5">

                        <div class="text-center">
                            <h4 class="mt-1 mb-4">Adding new test</h4>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/tests?action=add" method="post">
                            <select name="subjectSelect" class="form-select m-b-15" aria-label="subject selecting">
                                <option selected>Subject</option>
                                <c:forEach var="subject" items="${sessionScope.subjectsList}">
                                    <option value="${subject.id}">${subject.name}</option>
                                </c:forEach>
                            </select>

                            <div class="form-outline mb-3">
                                <input type="text" name="title" id="title" class="form-control"/>
                                <label class="form-label" for="title">Title</label>
                            </div>

                            <div class="form-outline mb-3">
                                <input type="text" name="description" id="description" class="form-control"/>
                                <label class="form-label" for="description">Description</label>
                            </div>

                            <select name="difficultySelect" class="form-select m-b-15" aria-label="difficulty selecting">
                                <option selected>Difficulty</option>
                                <option style="color: green" value="EASY">Easy</option>
                                <option style="color: orange" value="MEDIUM">Medium</option>
                                <option style="color: red" value="DIFFICULT">Difficult</option>
                            </select>

                            <div class="form-outline mb-3">
                                <input type="number" name="time" id="time" class="form-control"/>
                                <label class="form-label" for="time">Time (min.)</label>
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

    <!----------------------------------------------------------------------------------------->

    <header class="header">
        <div class="header-title">
            List of tests
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
        <button data-bs-toggle="modal" data-bs-target="#modal-add-test"
                type="button" class="btn btn-success btn-rounded">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                 fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"></path>
            </svg>
        </button>
    </header>

    <c:if test="${not empty sessionScope.addedTest}">
        <c:choose>
            <c:when test="${sessionScope.addedTest == 'success'}">
                <script>
                    swal("Success", "You have successfully added a new test!", "success");
                </script>
            </c:when>
            <c:when test="${sessionScope.addedTest == 'empty'}">
                <script>
                    swal("Empty input", "Please fill in the required fields", "warning");
                </script>
            </c:when>
            <c:when test="${sessionScope.addedTest == 'failed'}">
                <script>
                    swal("Error", "You failed to add a new test!", "error");
                </script>
            </c:when>
        </c:choose>
        <c:remove var="addedTest" scope="session"/>
    </c:if>

    <main>
        <table id="main-table" class="table align-middle mb-0 bg-white">
            <thead class="bg-light">
            <tr>
                <th class="table-th" onclick="sortTable(0)">
                    Subject
                    <span class="sort-picture" id="sort-up0" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down0"  hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(1)">
                    Title
                    <span class="sort-picture" id="sort-up1" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down1" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(2)">
                    Difficulty
                    <span class="sort-picture" id="sort-up2" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down2" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(3)">
                    Questions
                    <span class="sort-picture" id="sort-up3" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down3" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(4)">
                    Time (min.)
                    <span class="sort-picture" id="sort-up4" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down4" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th>Actions</th>
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
                                <b>${test.subject.name}</b>
                            </div>
                        </div>
                    </td>

                    <td>
                        ${test.title}
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${test.difficulty.name() == 'EASY'}">
                                <span class="badge badge-success rounded-pill d-inline">EASY</span>
                            </c:when>
                            <c:when test="${test.difficulty.name() == 'MEDIUM'}">
                                <span class="badge badge-warning rounded-pill d-inline">MEDIUM</span>
                            </c:when>
                            <c:when test="${test.difficulty.name() == 'DIFFICULT'}">
                                <span class="badge badge-danger rounded-pill d-inline">DIFFICULT</span>
                            </c:when>
                        </c:choose>
                    </td>

                    <td>
                        ${test.questionsList.size()}
                    </td>

                    <td>
                        ${test.time}
                    </td>

                    <td>
                        <button onclick="document.location='/admin/tests/edit?id=${test.id}'"
                                type="button" class="btn btn-link btn-sm btn-rounded">
                            Edit
                        </button>
                        <form action=""
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
    </script>

</body>
</html>