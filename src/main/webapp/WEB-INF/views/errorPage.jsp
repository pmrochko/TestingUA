<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>ErrorPage</title>
</head>
<body>

        ERROR!

        <c:if test="${not empty requestScope.errorMessage}">
            MESSAGE: ${requestScope.errorMessage}
        </c:if>

</body>
</html>
