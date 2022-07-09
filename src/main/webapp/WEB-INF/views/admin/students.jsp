<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Students</title>

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
        <%@ include file="../../styles/edit-students-modal-styles.css" %>
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/templates/menuAdmin.jsp"/>

    <!----------------------------------Students modal window---------------------------------->

    <c:if test="${requestScope.openModalEdit == true}">

        <div class="modal fade" id="modal-edit-user" tabindex="-1" aria-labelledby="modal-edit-user-label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content modalWindow">
                    <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                    <div class="modal-editUser col-lg-5" style="border-radius: 25px; border: 2px #FF8800 solid">
                        <div class="card-body p-md-3 mx-md-5">

                            <div class="text-center">
                                <h4 class="mt-1 mb-4">Editing user data</h4>
                            </div>

                            <form action="${pageContext.request.contextPath}/admin/students?action=edit" method="post">
                                <div class="form-outline mb-3">
                                    <input type="text" name="name" id="name" class="form-control"
                                           value="${sessionScope.editingUser.name}"/>
                                    <label class="form-label" for="name">Name</label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="text" name="surname" id="surname" class="form-control"
                                           value="${sessionScope.editingUser.surname}"/>
                                    <label class="form-label" for="surname">Surname</label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="email" name="email" id="email" class="form-control"
                                           value="${sessionScope.editingUser.email}"/>
                                    <label class="form-label" for="email">Email</label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="text" name="login" id="login" class="form-control"
                                           value="${sessionScope.editingUser.login}"/>
                                    <label class="form-label" for="login">Login</label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="tel" name="tel" id="tel" class="form-control"
                                           value="${sessionScope.editingUser.tel}"/>
                                    <label class="form-label" for="tel">Phone number</label>
                                </div>

                                <div class="text-center pt-1 mb-4">
                                    <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                            style="background-color: #FF8800; border: 1px grey solid" type="submit">Edit</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            $(document).ready(function(){
                $("#modal-edit-user").modal('show');
            });
        </script>

        <c:remove var="openModalEdit" scope="request"/>
    </c:if>

    <!----------------------------------------------------------------------------------------->

    <main>

        <table id="main-table" class="table align-middle mb-0 bg-white">

            <thead class="bg-light">
            <tr>
                <th class="table-th" onclick="sortTable(0)">
                    Name
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
                    Login
                    <span class="sort-picture" id="sort-up1" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down1"  hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(2)">
                    Phone number
                    <span class="sort-picture" id="sort-up2" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down2"  hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(3)">
                    Passed tests
                    <span class="sort-picture" id="sort-up3" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down3"  hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th class="table-th" onclick="sortTable(4)">
                    Status
                    <span class="sort-picture" id="sort-up4" hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                            <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                    <span class="sort-picture" id="sort-down4"  hidden="hidden">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                            <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"></path>
                        </svg>
                    </span>
                </th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>

            <c:forEach var="user" items="${requestScope.usersList}">
                <c:if test="${user.role.name() == 'STUDENT'}">

                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <img
                                        src="${pageContext.request.contextPath}/images/user-icon.png"
                                        alt=""
                                        style="width: 45px; height: 45px"
                                        class="rounded-circle"
                                />
                                <div class="ms-3">
                                    <p class="fw-bold mb-1">${user.name} ${user.surname}</p>
                                    <p class="text-muted mb-0">${user.email}</p>
                                </div>
                            </div>
                        </td>
                        <td>
                            ${user.login}
                        </td>
                        <td>
                            ${user.tel}
                        </td>
                        <td style="padding-left: 40px;">
                            ${user.countOfPassedTests()}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.blocked == false}">
                                    <span class="badge badge-success rounded-pill d-inline">Normal</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger rounded-pill d-inline">Blocked</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button onclick="document.location='/admin/students?editingUserID=${user.id}'"
                                    type="button"
                                    class="btn btn-link btn-sm btn-rounded">
                                Edit
                            </button>
                            <c:choose>
                                <c:when test="${user.blocked == true}">
                                    <form action="${pageContext.request.contextPath}/admin/students?action=unblock&userID=${user.id}"
                                          method="post"
                                          class="mb-0">
                                        <button style="color: #31e300"
                                                type="submit"
                                                class="btn btn-link btn-rounded btn-sm fw-bold"
                                                data-mdb-ripple-color="dark"
                                        >
                                            UNBLOCK
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin/students?action=block&userID=${user.id}"
                                          method="post"
                                          class="mb-0">
                                        <button style="color: #e30000"
                                                type="submit"
                                                class="btn btn-link btn-rounded btn-sm fw-bold"
                                                data-mdb-ripple-color="dark"
                                        >
                                            BLOCK
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                </c:if>
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