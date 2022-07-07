package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.entity.User;
import com.myproject.testingua.models.enums.TestProgressStatus;
import com.myproject.testingua.utils.PDF.PDFBuilder;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CreatePDFServlet", value = "/student/openResultInPDF")
public class CreatePDFServlet extends HttpServlet {

    private static final long serialVersionUID = 5213718233554290566L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        Test test = (Test) session.getAttribute("startedTest");
        long testResult = (long) session.getAttribute("testResult");
        TestProgressStatus status = (TestProgressStatus) session.getAttribute("testStatus");

        PDFBuilder.testResultPDF(request, response, user, test, status.name(), testResult + "%");

    }

}
