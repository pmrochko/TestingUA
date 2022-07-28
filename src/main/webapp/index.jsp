<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                   aria-controls="pills-login" aria-selected="true">Login</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="tab-register" data-mdb-toggle="pill" href="#pills-register" role="tab"
                   aria-controls="pills-register" aria-selected="false">Register</a>
            </li>
        </ul>

        <!-- Pills content -->
        <div class="tab-content">
            <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">

                <c:choose>
                    <c:when test="${sessionScope.loginStatus.equals('banned')}">
                        <div class="mb-3 mt-5" style="text-align: center; color: red;">
                            Your account has been blocked
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.loginStatus.equals('empty')}">
                        <div class="mb-3 mt-5" style="text-align: center; color: #ff7300;">
                            Fill in all the fields and try again
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.loginStatus.equals('failed')}">
                        <div class="mb-3 mt-5" style="text-align: center; color: red;">
                            You have entered incorrect data
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-3 mt-5" style="text-align: center;">
                            Please login to your account
                        </div>
                    </c:otherwise>
                </c:choose>
                <c:remove var="loginStatus" scope="session"/>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <!-- Login input -->
                    <div class="form-outline mb-4">
                        <input name="login" type="text" id="loginName" class="form-control" required/>
                        <label class="form-label" for="loginName">Login</label>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-6">
                        <input name="password" type="password" id="loginPassword" class="form-control" required/>
                        <label class="form-label" for="loginPassword">Password</label>
                    </div>

                    <!-- 2 column grid layout -->
                    <div class="row mb-4">
                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- Checkbox -->
                            <div class="form-check mb-3 mb-md-0">
                                <input class="form-check-input" type="checkbox" value="" id="loginCheck"/>
                                <label class="form-check-label" for="loginCheck"> Remember me </label>
                            </div>
                        </div>

                        <div class="col-md-6 d-flex justify-content-center">
                            <!-- Simple link -->
                            <a href="">Forgot password?</a>
                        </div>
                    </div>

                    <!-- Submit button -->
                    <input id="signIn" type="submit" value="Sign in" class="btn btn-primary btn-block mb-4"/>

                    <!-- Register buttons -->
                    <div class="text-center">
                        <p>Not a member? <a href="#" onclick="document.querySelector('#tab-register').click()">Register</a></p>
                    </div>
                </form>

            </div>
            <div class="tab-pane fade" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                <form action="${pageContext.request.contextPath}/registration" method="post">
                    <div id="regFormMessage" class="mb-3" style="text-align: center;">
                        Filling out the registration form
                    </div>
                    <!-- Name input -->
                    <div class="form-outline mb-4">
                        <input name="name" type="text" id="registerName" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerName">Name</label>
                    </div>

                    <!-- Surname input -->
                    <div class="form-outline mb-4">
                        <input name="surname" type="text" id="registerSurname" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerSurname">Surname</label>
                    </div>

                    <!-- Login input -->
                    <div class="form-outline mb-4">
                        <input name="login" type="text" id="registerLogin" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerLogin">Login</label>
                    </div>

                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <input name="email" type="email" id="registerEmail" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerEmail">Email</label>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-4">
                        <input name="password" type="password" id="registerPassword" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerPassword">Password</label>
                    </div>

                    <!-- Repeat Password input -->
                    <div class="form-outline mb-4">
                        <input name="repeatPassword" type="password" id="registerRepeatPassword" class="form-control"
                               required autocomplete="off"/>
                        <label class="form-label" for="registerRepeatPassword">Repeat password</label>
                    </div>

                    <!-- Checkbox -->
                    <div class="form-check d-flex justify-content-center mb-4">
                        <input name="checkbox" class="form-check-input me-2" type="checkbox" value="" id="registerCheck"
                               aria-describedby="registerCheckHelpText"
                               required autocomplete="off"/>
                        <label class="form-check-label" for="registerCheck">
                            I have read and agree to the terms
                        </label>
                    </div>

                    <!-- Submit button -->
                    <button type="submit" class="btn btn-primary btn-block mb-3">Sign up</button>
                </form>

                <c:if test="${not empty sessionScope.invalidInput}">
                    <c:choose>
                        <c:when test="${sessionScope.invalidInput == 'name'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "Invalid name entered";
                                message.style.color = "red";
                                document.getElementById('registerName').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'surname'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "Invalid surname entered";
                                message.style.color = "red";
                                document.getElementById('registerSurname').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'login'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "Invalid login entered";
                                message.style.color = "red";
                                document.getElementById('registerLogin').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'email'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "Invalid email entered";
                                message.style.color = "red";
                                document.getElementById('registerEmail').style.backgroundColor = "#ffe8e8";
                            </script>
                        </c:when>
                        <c:when test="${sessionScope.invalidInput == 'password'}">
                            <script>
                                let message = document.querySelector('#regFormMessage');
                                message.textContent = "Invalid password entered";
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