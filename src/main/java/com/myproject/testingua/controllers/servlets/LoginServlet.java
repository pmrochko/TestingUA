package com.myproject.testingua.controllers.servlets;

import com.myproject.testingua.DataBase.DAO.impl.UserDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.User;
import com.myproject.testingua.models.enums.UserRole;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 2507826481204993822L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendError(404);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        if (login == null || password == null || login.isBlank() || password.isBlank()) {

            session.setAttribute("loginStatus", "empty");
            response.sendRedirect("/");

        } else {

            User user = null;
            try {
                user = new UserDAOImpl().findUserByLogin(login);
            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                session.setAttribute("prevPage", getServletContext().getContextPath());
                response.sendRedirect("/error");
                return;
            }

            if (user != null && user.getPassword().equals(password)) {
                if (user.isBlocked()) {
                    session.setAttribute("loginStatus", "banned");
                    response.sendRedirect("/");
                } else {
                    session.setAttribute("loginStatus", "success");
                    session.setAttribute("currentUser", user);
                    if (user.getRole() == UserRole.ADMIN)
                        response.sendRedirect("/admin");
                    else
                        response.sendRedirect("/student");
                }
            } else {
                session.setAttribute("loginStatus", "failed");
                response.sendRedirect("/");
            }
        }
    }
}
