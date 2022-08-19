<%@ include file="../templates/libsAndLocale.jspf" %>

<html>
<head>
    <title><fmt:message key="admin.studentsPage"/></title>

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
        <%@ include file="../../styles/edit-students-styles.css" %>
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
                                <h4 class="mt-1 mb-4">
                                    <fmt:message key="user.edit"/>
                                </h4>
                            </div>

                            <form action="${pageContext.request.contextPath}/admin/students?action=edit" method="post">
                                <div class="form-outline mb-3">
                                    <input type="text" name="name" id="name" class="form-control"
                                           value="${sessionScope.editingUser.name}"/>
                                    <label class="form-label" for="name">
                                        <fmt:message key="name"/>
                                    </label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="text" name="surname" id="surname" class="form-control"
                                           value="${sessionScope.editingUser.surname}"/>
                                    <label class="form-label" for="surname">
                                        <fmt:message key="surname"/>
                                    </label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="email" name="email" id="email" class="form-control"
                                           value="${sessionScope.editingUser.email}"/>
                                    <label class="form-label" for="email">
                                        <fmt:message key="email"/>
                                    </label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="text" name="login" id="login" class="form-control"
                                           value="${sessionScope.editingUser.login}"/>
                                    <label class="form-label" for="login">
                                        <fmt:message key="login"/>
                                    </label>
                                </div>

                                <div class="form-outline mb-3">
                                    <input type="tel" name="tel" id="tel" class="form-control"
                                           value="${sessionScope.editingUser.tel}"/>
                                    <label class="form-label" for="tel">
                                        <fmt:message key="phoneNumber"/>
                                    </label>
                                </div>

                                <div class="text-center pt-1 mb-4">
                                    <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                            style="background-color: #FF8800; border: 1px grey solid" type="submit">
                                        <fmt:message key="actions.edit"/>
                                    </button>
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

    <header class="header">
        <div class="header-title">
            <fmt:message key="admin.studentsPage.headerTitle"/>
        </div>
        <div class="input-group search">
            <div class="form-outline">
                <input type="search" id="searchForm" class="form-control bg-dark" onkeyup="searchFunction('names')"/>
                <label class="form-label" for="searchForm"><fmt:message key="search.byName"/></label>
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
                <my:columnTitle index="0" name="name"/>
                <my:columnTitle index="1" name="login"/>
                <my:columnTitle index="2" name="phoneNumber"/>
                <my:columnTitle index="3" name="passedTests"/>
                <my:columnTitle index="4" name="status"/>
                <th><fmt:message key="actions"/></th>
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
                                    <span class="badge badge-success rounded-pill d-inline">
                                        <fmt:message key="user.banStatus.normal"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger rounded-pill d-inline">
                                        <fmt:message key="user.banStatus.blocked"/>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button onclick="document.location='/admin/students?editingUserID=${user.id}'"
                                    type="button"
                                    class="btn btn-link btn-sm btn-rounded">
                                <fmt:message key="actions.edit"/>
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
                                            <fmt:message key="actions.unblock"/>
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
                                            <fmt:message key="actions.block"/>
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
        <%@ include file="../../scripts/search-form-script.js" %>
    </script>

</body>
</html>