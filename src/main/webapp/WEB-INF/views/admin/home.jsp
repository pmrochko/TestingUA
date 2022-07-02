<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Menu</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
          rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.2.0/mdb.min.css"
          rel="stylesheet"/>

    <style>
        <%@ include file="../../styles/admin-home-styles.css" %>
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/templates/menuAdmin.jsp"/>

    <main>

        <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
            <img src="../../../images/admin/sysAdmin-icon.png"
                 class="card-img-top" alt="System administrator" style="max-width: 12rem"/>
            <div class="card-header">System</div>
            <div class="card-body">
                <h5 class="card-title m-b-20">System administrator</h5>
                <p class="card-text">
                    - creates, deletes or edits tests;
                    <br>
                    - blocks, unlocks, edits the user.
                    <br><br>
                </p>
            </div>
        </div>

        <div class="card text-white bg-dark mb-3" style="max-width: 18rem;">
            <img src="../../../images/admin/creating-tests-icon.png"
                 class="card-img-top" alt="Sunset Over the Sea" style="max-width: 10rem"/>
            <div class="card-header">Tests</div>
            <div class="card-body">
                <h5 class="card-title m-b-20">Creating tests</h5>
                <p class="card-text">
                    - sets the time of the test;
                    <br>
                    - complexity of the test;
                    <br>
                    - adds Questions to the test
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
