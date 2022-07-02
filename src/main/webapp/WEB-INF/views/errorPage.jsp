<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>ErrorPage</title>
</head>
<body>

        ERROR!

        <c:if test="${not empty sessionScope.errorMessage}">
            MESSAGE: ${sessionScope.errorMessage}
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

</body>
</html>
