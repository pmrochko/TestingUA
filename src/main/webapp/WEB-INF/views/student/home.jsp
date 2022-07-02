<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Student Menu</title>

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
<body>

    <jsp:include page="/WEB-INF/views/templates/menuStudent.jsp"/>

    <main>

        <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
            <img src="../../../images/student/website-icon.png"
                 class="card-img-top" alt="System administrator" style="max-width: 10rem"/>
            <div class="card-header">Welcome</div>
            <div class="card-body">
                <h5 class="card-title m-b-20">Our service</h5>
                <p class="card-text">
                    On our site you can take tests in various subjects and determine your level of knowledge.
                    <br><br>
                </p>
            </div>
        </div>

        <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
            <img src="../../../images/student/testing-icon.png"
                 class="card-img-top" alt="Sunset Over the Sea" style="max-width: 10rem"/>
            <div class="card-header">Action</div>
            <div class="card-body">
                <h5 class="card-title m-b-20">Testing</h5>
                <p class="card-text">
                    There is a list of tests on Subjects in the system.
                    From the list of tests can be sorted by name, complexity, number of questions.
                </p>
            </div>
        </div>

        <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
            <img src="../../../images/student/history.png"
                 class="card-img-top" alt="Sunset Over the Sea" style="max-width: 10rem"/>
            <div class="card-header">Profile & History</div>
            <div class="card-body">
                <h5 class="card-title m-b-20">Personal data</h5>
                <p class="card-text">
                    You have a personal profile that displays registration information,
                    as well as a list of tests taken with the results.
                </p>
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
