<%@ include file="../templates/libsAndLocale.jspf" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        <%@ include file="../../styles/error-404.css" %>
    </style>
</head>
<body>
    <h1>OOPS!</h1>
    <h2>ERROR - ${sessionScope.errorMessage}</h2>
    <button onclick="document.location='http://localhost:8080/${sessionScope.prevPage}'">GO TO THE PREVIOUS PAGE</button>
    <c:remove var="errorMessage" scope="session"/>
    <c:remove var="prevPage" scope="session"/>
</body>
</html>