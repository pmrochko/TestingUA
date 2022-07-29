package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.controllers.Path;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AdminServlet", value = "/admin")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = -7130026396522732915L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher(Path.ADMIN_HOME_PAGE).forward(request, response);

    }

}