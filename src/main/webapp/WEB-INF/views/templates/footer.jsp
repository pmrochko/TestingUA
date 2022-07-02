<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="bg-dark text-center text-white">

    <c:if test="${empty sessionScope.currentUser}">
        <div class="container p-4 pb-0">
            <section class="">
                <p class="d-flex justify-content-center align-items-center">
                    <span class="me-3">Register for free</span>
                    <button type="button" class="btn btn-outline-light btn-rounded">
                        Sign up!
                    </button>
                </p>
            </section>
        </div>
    </c:if>

    <!-- Copyright -->
    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
        © 2022 Copyright:
        <a class="text-white" href="#">TestingUA</a>
    </div>
    <!-- Copyright -->
</footer>