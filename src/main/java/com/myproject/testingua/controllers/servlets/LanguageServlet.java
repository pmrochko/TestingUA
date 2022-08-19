package com.myproject.testingua.controllers.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LanguageServlet", value = "/language")
public class LanguageServlet extends HttpServlet {

    private static final long serialVersionUID = 529021594612445597L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(404);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String language = request.getParameter("lang");
        response.addCookie(new Cookie("lang", language));

        response.sendRedirect("/");
    }
}