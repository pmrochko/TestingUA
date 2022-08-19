<%@ include file="../templates/libsAndLocale.jspf" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>500</title>
    <style>
        <%@ include file="../../styles/error-404.css" %>
    </style>
</head>
<body>
    <h1>OOPS!</h1>
    <h2>500 - Internal Server Error</h2>
    <button onclick="document.location='http://localhost:8080/'">GO TO HOMEPAGE</button>
</body>
</html>