<%@ include file="../templates/libsAndLocale.jspf" %>

<html>
<head>
    <title>
        <fmt:message key="menu.student"/>
    </title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
          rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.css"
          rel="stylesheet"/>

    <style>
        <%@ include file="../../styles/student-home-styles.css" %>
    </style>
</head>
<body class="bg-dark">

    <jsp:include page="../templates/menuStudent.jsp"/>
    <jsp:include page="../templates/languageSelect.jsp"/>

    <main>

        <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
            <img src="../../../images/student/website-icon.png"
                 class="card-img-top" alt="System administrator" style="max-width: 10rem"/>
            <div class="card-header">
                <fmt:message key="student.homePage.card_1.title"/>
            </div>
            <div class="card-body">
                <h5 class="card-title m-b-20">
                    <fmt:message key="student.homePage.card_1.description.title"/>
                </h5>
                <p class="card-text">
                    <fmt:message key="student.homePage.card_1.description"/>
                    <br><br>
                </p>
            </div>
        </div>

        <div onclick="document.location='http://localhost:8080/student/tests'"
             class="card text-white bg-dark mb-3 onclick-anim" style="max-width: 18rem;">
            <img src="../../../images/student/testing-icon.png"
                 class="card-img-top" alt="Sunset Over the Sea" style="max-width: 10rem"/>
            <div class="card-header">
                <fmt:message key="student.homePage.card_2.title"/>
            </div>
            <div class="card-body">
                <h5 class="card-title m-b-20">
                    <fmt:message key="student.homePage.card_2.description.title"/>
                </h5>
                <p class="card-text">
                    <fmt:message key="student.homePage.card_2.description"/>
                </p>
            </div>
            <div class="onclick-picture">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-hand-index-thumb" viewBox="0 0 16 16">
                    <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 0 0 1 0V6.435l.106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 1 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.118a.5.5 0 0 1-.447-.276l-1.232-2.465-2.512-4.185a.517.517 0 0 1 .809-.631l2.41 2.41A.5.5 0 0 0 6 9.5V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v6.543L3.443 6.736A1.517 1.517 0 0 0 1.07 8.588l2.491 4.153 1.215 2.43A1.5 1.5 0 0 0 6.118 16h6.302a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"></path>
                </svg>
            </div>
        </div>

        <div onclick="document.location='http://localhost:8080/student/history'"
             class="card text-white bg-dark mb-3 onclick-anim" style="max-width: 18rem;">
            <img src="../../../images/student/history.png"
                 class="card-img-top" alt="Sunset Over the Sea" style="max-width: 10rem"/>
            <div class="card-header">
                <fmt:message key="student.homePage.card_3.title"/>
            </div>
            <div class="card-body">
                <h5 class="card-title m-b-20">
                    <fmt:message key="student.homePage.card_3.description.title"/>
                </h5>
                <p class="card-text">
                    <fmt:message key="student.homePage.card_3.description"/>
                </p>
            </div>
            <div class="onclick-picture">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-hand-index-thumb" viewBox="0 0 16 16">
                    <path d="M6.75 1a.75.75 0 0 1 .75.75V8a.5.5 0 0 0 1 0V5.467l.086-.004c.317-.012.637-.008.816.027.134.027.294.096.448.182.077.042.15.147.15.314V8a.5.5 0 0 0 1 0V6.435l.106-.01c.316-.024.584-.01.708.04.118.046.3.207.486.43.081.096.15.19.2.259V8.5a.5.5 0 1 0 1 0v-1h.342a1 1 0 0 1 .995 1.1l-.271 2.715a2.5 2.5 0 0 1-.317.991l-1.395 2.442a.5.5 0 0 1-.434.252H6.118a.5.5 0 0 1-.447-.276l-1.232-2.465-2.512-4.185a.517.517 0 0 1 .809-.631l2.41 2.41A.5.5 0 0 0 6 9.5V1.75A.75.75 0 0 1 6.75 1zM8.5 4.466V1.75a1.75 1.75 0 1 0-3.5 0v6.543L3.443 6.736A1.517 1.517 0 0 0 1.07 8.588l2.491 4.153 1.215 2.43A1.5 1.5 0 0 0 6.118 16h6.302a1.5 1.5 0 0 0 1.302-.756l1.395-2.441a3.5 3.5 0 0 0 .444-1.389l.271-2.715a2 2 0 0 0-1.99-2.199h-.581a5.114 5.114 0 0 0-.195-.248c-.191-.229-.51-.568-.88-.716-.364-.146-.846-.132-1.158-.108l-.132.012a1.26 1.26 0 0 0-.56-.642 2.632 2.632 0 0 0-.738-.288c-.31-.062-.739-.058-1.05-.046l-.048.002zm2.094 2.025z"></path>
                </svg>
            </div>
        </div>

    </main>

    <footer class="footer">
        <jsp:include page="../templates/footer.jsp"/>
    </footer>

    <!-- MDB -->
    <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.js"
    ></script>
</body>
</html>
