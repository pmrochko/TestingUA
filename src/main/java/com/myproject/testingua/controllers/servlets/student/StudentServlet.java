package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.controllers.Path;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "StudentServlet", value = "/student")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 3882524544273419012L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher(Path.STUDENT_HOME_PAGE).forward(request, response);

    }

}