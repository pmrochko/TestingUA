<%@ include file="templates/libsAndLocale.jspf" %>

<html>
<head>
    <title><fmt:message key="admin.profilePage"/></title>

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
        <%@ include file="../styles/profile-styles.css" %>
    </style>
</head>
<body class="bg-dark">

    <c:choose>
        <c:when test="${sessionScope.currentUser.role.name() == 'ADMIN'}">
            <jsp:include page="/WEB-INF/views/templates/menuAdmin.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="/WEB-INF/views/templates/menuStudent.jsp"/>
        </c:otherwise>
    </c:choose>

    <!----------------------------------Profile modal window---------------------------------->
    <div class="modal fade" id="modal-edit-password" tabindex="-1" aria-labelledby="modal-edit-password-label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modalWindow">
                <button class="btn-close close-modal-btn" style="margin-right: 23%" data-bs-dismiss="modal" aria-label="close"></button>
                <div class="modal-changePass col-lg-5" style="border-radius: 25px; border: 2px #FF8800 solid">
                    <div class="card-body p-md-3 mx-md-5">

                        <div class="text-center">
                            <h4 class="mt-1 mb-4">
                                <fmt:message key="actions.changePassword"/>
                            </h4>
                        </div>

                        <form action="${pageContext.request.contextPath}/profile?action=edit&form=passwordForm" method="post">
                            <div class="form-outline mb-3">
                                <input type="password" name="curr-pass" id="pass1" class="form-control"/>
                                <label class="form-label" for="pass1">
                                    <fmt:message key="password.current"/>
                                </label>
                            </div>
                            <div class="form-outline mb-3">
                                <input type="password" name="new-pass" id="pass2" class="form-control"/>
                                <label class="form-label" for="pass2">
                                    <fmt:message key="password.new"/>
                                </label>
                            </div>
                            <div class="form-outline mb-3">
                                <input type="password" name="repeat-new-pass" id="pass3" class="form-control"/>
                                <label class="form-label" for="pass3">
                                    <fmt:message key="password.new.reply"/>
                                </label>
                            </div>

                            <c:if test="${not empty sessionScope.changePassword}">
                                <c:choose>
                                    <c:when test="${sessionScope.changePassword == 'success'}">
                                        <div class="progress-description text-green">You have successfully changed your password!</div>
                                        <script>
                                            swal("Success", "You have successfully changed your password!", "success");
                                        </script>
                                    </c:when>
                                    <c:when test="${sessionScope.changePassword == 'failed'}">
                                        <div class="progress-description text-red">Failed to change password!</div>
                                        <script>
                                            swal("Error", "Failed to change password!", "error");
                                        </script>
                                    </c:when>
                                    <c:when test="${sessionScope.changePassword == 'incorrectInput'}">
                                        <div class="progress-description text-red">The entered data is incorrect!</div>
                                        <script type="text/javascript">
                                            $(document).ready(function(){
                                                $("#modal-edit-password").modal('show');
                                            });
                                        </script>
                                    </c:when>
                                    <c:when test="${sessionScope.changePassword == 'emptyInput'}">
                                        <div class="progress-description text-orange">Fill in all fields!</div>
                                        <script type="text/javascript">
                                            $(document).ready(function(){
                                                $("#modal-edit-password").modal('show');
                                            });
                                        </script>
                                    </c:when>
                                </c:choose>
                                <c:remove var="changePassword" scope="session"/>
                            </c:if>

                            <div class="text-center pt-1 mb-4">
                                <button class="btn btn-primary btn-block fa-lg mb-3 text-black"
                                        style="background-color: #FF8800; border: 1px grey solid" type="submit">
                                    <fmt:message key="actions.change"/>
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!----------------------------------------------------------------------------------------->

    <main>
        <div class="page-content page-container" id="page-content">
            <div class="padding">
                <div class="row container d-flex justify-content-center">
                    <div class="col-xl-8">
                        <div class="card user-card-full">
                            <div class="row m-l-0 m-r-0">
                                <div class="col-sm-4 bg-c-lite-green user-profile">
                                    <div class="card-block text-center text-white">
                                        <div class="m-b-25">
                                            <img src="https://img.icons8.com/bubbles/100/000000/user.png" class="img-radius" alt="User-Profile-Image">
                                        </div>
                                        <h5 class="f-w-600">
                                            ${sessionScope.currentUser.surname} ${sessionScope.currentUser.name}
                                        </h5>
                                        <form action="${pageContext.request.contextPath}/profile?action=edit&form=surnameForm" method="post" class="edit-form mb-1">
                                            <label>
                                                <input style="display: none" name="surname" placeholder="<fmt:message key="surname"/>" class="edit-profile-box edit-field" type="text"/>
                                                <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                            </label>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/profile?action=edit&form=nameForm" method="post" class="edit-form">
                                            <label>
                                                <input style="display: none" name="name" placeholder="<fmt:message key="name"/>" class="edit-profile-box edit-field" type="text"/>
                                                <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                            </label>
                                        </form>

                                        <c:choose>
                                            <c:when test="${sessionScope.currentUser.role.toString() == 'ADMIN'}">
                                                <p><fmt:message key="administrator"/></p>
                                            </c:when>
                                            <c:when test="${sessionScope.currentUser.role.toString() == 'STUDENT'}">
                                                <p><fmt:message key="student"/></p>
                                            </c:when>
                                        </c:choose>

                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                                            <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"></path>
                                        </svg>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <div class="card-block">
                                        <h6 class="m-b-20 p-b-5 b-b-default f-w-600"><fmt:message key="information"/></h6>
                                        <div class="row">

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600"><fmt:message key="email"/></p>
                                                <h6 class="text-muted f-w-400">${sessionScope.currentUser.email}</h6>
                                                <form action="${pageContext.request.contextPath}/profile?action=edit&form=emailForm" method="post" class="edit-form">
                                                    <label>
                                                        <input style="display: none" name="email" class="edit-profile-box edit-field" type="email"/>
                                                        <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                    </label>
                                                </form>
                                            </div>

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600"><fmt:message key="phoneNumber"/></p>
                                                <h6 class="text-muted f-w-400">
                                                    <c:choose>
                                                        <c:when test="${not empty sessionScope.currentUser.tel}">
                                                            ${sessionScope.currentUser.tel}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ---
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h6>
                                                <form action="${pageContext.request.contextPath}/profile?action=edit&form=telForm" method="post" class="edit-form">
                                                    <label>
                                                        <input style="display: none" name="tel" class="edit-profile-box edit-field" type="tel"/>
                                                        <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                    </label>
                                                </form>
                                            </div>

                                        </div>

                                        <div class="row">

                                            <div class="col-sm-6">
                                                <p class="m-b-10 f-w-600"><fmt:message key="login"/></p>
                                                <h6 class="text-muted f-w-400">${sessionScope.currentUser.login}</h6>
                                                <form action="${pageContext.request.contextPath}/profile?action=edit&form=loginForm" method="post" class="edit-form">
                                                    <label>
                                                        <input style="display: none" name="login" class="edit-profile-box edit-field" type="text"/>
                                                        <input style="display: none" class="edit-profile-box edit-button" type="submit" value="✓"/>
                                                    </label>
                                                </form>
                                            </div>

                                            <div class="col-sm-6">
                                                <c:if test="${sessionScope.currentUser.role.name() == 'STUDENT'}">
                                                    <p class="m-b-10 f-w-600"><fmt:message key="passedTests"/></p>
                                                    <h6 class="text-muted f-w-400">${sessionScope.currentUser.countOfPassedTests()}</h6>
                                                </c:if>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <button onclick="trigger_show()">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
                                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
                                                </svg>
                                                <fmt:message key="actions.edit"/>
                                            </button>
                                        </div>

                                        <h6 class="m-b-20 m-t-40 p-b-5 b-b-default f-w-600"><fmt:message key="password"/></h6>
                                        <div class="row">
                                            <button data-bs-toggle="modal" data-bs-target="#modal-edit-password">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key-fill" viewBox="0 0 16 16">
                                                    <path d="M3.5 11.5a3.5 3.5 0 1 1 3.163-5H14L15.5 8 14 9.5l-1-1-1 1-1-1-1 1-1-1-1 1H6.663a3.5 3.5 0 0 1-3.163 2zM2.5 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
                                                </svg>
                                                <fmt:message key="actions.changePassword"/>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <jsp:include page="templates/footer.jsp"/>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.js"></script>

    <script> <%@ include file="../scripts/edit-profile-script.js" %> </script>

</body>
</html>