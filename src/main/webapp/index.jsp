<%@ include file="WEB-INF/views/templates/libsAndLocale.jspf" %>

<!DOCTYPE html>
<html>
<head>
    <title>TestingUA</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
            rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.css"
            rel="stylesheet"/>

    <style>
        <%@ include file="/WEB-INF/styles/index-styles.css" %>
    </style>
    <c:if test="${not empty sessionScope.currentUser}">
        <c:choose>
            <c:when test="${sessionScope.currentUser.role.name() == 'STUDENT'}">
                <script>
                    document.location='http://localhost:8080/student';
                </script>
            </c:when>
            <c:when test="${sessionScope.currentUser.role.name() == 'ADMIN'}">
                <script>
                    document.location='http://localhost:8080/admin';
                </script>
            </c:when>
        </c:choose>
    </c:if>
</head>
<body>

    <a class="navbar-brand start-logo" href="${pageContext.request.contextPath}/">
        <img src="images/testingUA.png" alt="logo" style="width: 40px">
        TestingUA
    </a>

    <jsp:include page="WEB-INF/views/templates/languageSelect.jsp"/>

    <div class="start-content">
        <!-- Pills navs -->
        <ul class="nav nav-pills nav-justified mb-4" id="ex1" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="tab-login" data-mdb-toggle="pill" href="#pills-login" role="tab"
                   aria-controls="pills-login" aria-selected="true"><fmt:message key="button.login"/></a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="tab-register" data-mdb-toggle="pill" href="#pills-register" role="tab"
                   aria-controls="pills-register" aria-selected="false"><fmt:message key="button.registration"/></a>
            </li>
        </ul>

        <!-- Pills content -->
        <div class="tab-content">
            <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">

                <c:choose>
                    <c:when test="${sessionScope.loginStatus.equals('banned')}">
                        <div class="mb-3 mt-5" style="text-align: center; color: red;">
                            <fmt:message key="login.message.blocked"/>
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.loginStatus.equals('empty')}">
                        <div class="mb-3 mt-5" style="text-align: center; color: #ff7300;">
                            <fmt:message key="login.message.empty"/>
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.loginStatus.equals('failed')}">
                        <div class="mb-3 mt-5" style="text-align: center; color: red;">
                            <fmt:message key="login.message.failed"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-3 mt-5" style="text-align: center;">
                            <fmt:message key="login.message.welcome"/>
                        </div>
                    </c:otherwise>
                </c:choose>
                <c:remove var="loginStatus" scope="session"/>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <!-- Login input -->
                    <div class="form-outline mb-4">
                        <input name="login" type="text" id="loginName" class="form-control" required/>
                        <label class="form-label" for="loginName"><fmt:message key="login"/></label>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-6">
                        <input name="password" type="password" id="loginPassword" class="form-control" required/>
                        <label class="form-label" for="loginPassword"><fmt:message key="password"/></label>
                    </div>

                    <!-- Submit button -->
                    <input id="signIn" type="submit" class="btn btn-primary btn-block mb-4"
                           value="<fmt:message key="login.submit"/>"/>

                    <!-- Register buttons -->
                    <div class="text-center">
                        <p>
                            <fmt:message key="registration.nMember"/>
                            <a href="#" onclick="document.querySelector('#tab-register').click()">
                                <fmt:message key="button.registration"/>
                            </a>
                        </p>
                    </div>
                </form>

            </div>
            <div class="tab-pane fade" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                <form action="${pageContext.request.contextPath}/registration" method="post">
                    <div id="regFormMessage" class="mb-3" style="text-align: center;">
                        <fmt:message key="registration.message.welcome"/>
                    </div>
                    <!-- Name input -->
                    <div class="form-outline mb-4">
                        <input name="name" type="text" id="registerName" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerName"><fmt:message key="name"/></label>
                    </div>

                    <!-- Surname input -->
                    <div class="form-outline mb-4">
                        <input name="surname" type="text" id="registerSurname" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerSurname"><fmt:message key="surname"/></label>
                    </div>

                    <!-- Login input -->
                    <div class="form-outline mb-4">
                        <input name="login" type="text" id="registerLogin" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerLogin"><fmt:message key="login"/></label>
                    </div>

                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <input name="email" type="email" id="registerEmail" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerEmail"><fmt:message key="email"/></label>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-4">
                        <input name="password" type="password" id="registerPassword" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerPassword"><fmt:message key="password"/></label>
                    </div>

                    <!-- Repeat Password input -->
                    <div class="form-outline mb-4">
                        <input name="repeatPassword" type="password" id="registerRepeatPassword" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerRepeatPassword"><fmt:message key="password.repeat"/></label>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check d-flex justify-content-center mb-4">
                        <input name="checkbox" class="form-check-input me-2" type="checkbox" value="" id="registerCheck"
                               aria-describedby="registerCheckHelpText"
                               required autocomplete="off"/>
                        <label class="form-check-label" for="registerCheck">
                            <fmt:message key="registration.checkbox"/>
                        </label>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="btn btn-primary btn-block mb-3"><fmt:message key="registration.submit"/></button>
                </form>

                <c:if test="${not empty sessionScope.invalidInput}">
                    <c:choose>
                        <c:when test="${sessionScope.invalidInput == 'name'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "<fmt:message key="registration.invalidInput.name"/>";
                                message.style.color = "red";
                                document.getElementById('registerName').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'surname'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "<fmt:message key="registration.invalidInput.surname"/>";
                                message.style.color = "red";
                                document.getElementById('registerSurname').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'login'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "<fmt:message key="registration.invalidInput.login"/>";
                                message.style.color = "red";
                                document.getElementById('registerLogin').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'email'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "<fmt:message key="registration.invalidInput.email"/>";
                                message.style.color = "red";
                                document.getElementById('registerEmail').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'password'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "<fmt:message key="registration.invalidInput.password"/>";
                                message.style.color = "red";
                                document.getElementById('registerPassword').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                    </c:choose>
                </c:if>

            </div>
        </div>
    </div>

    <!-- MDB -->
    <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.js"
    ></script>
    <c:if test="${not empty sessionScope.invalidInput}">
        <script>
            document.querySelector('#tab-register').click();
        </script>
        <c:remove var="invalidInput" scope="session"/>
    </c:if>
</body>
</html>