package com.myproject.testingua.controllers.servlets;

import com.myproject.testingua.DataBase.DAO.UserDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.validation.DataValidator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RegistrationServlet", value = "/registration")
public class RegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1722555338375836421L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String login = request.getParameter("login");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeatPassword = request.getParameter("repeatPassword");
        String checkbox = request.getParameter("checkbox");

        // data validation
        boolean validData = DataValidator.isValidRegistrationForm(
                session, name, surname, login, email, password
        );

        if (checkbox != null && name != null && surname != null && login != null && email != null && password != null && repeatPassword != null &&
                !name.isBlank() && !surname.isBlank() && !login.isBlank() && !email.isBlank() && !password.isBlank() && !repeatPassword.isBlank() &&
                password.equals(repeatPassword) && validData) {

            UserDAO userDAO = null;
            try {
                userDAO = new UserDAO();
            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                response.sendRedirect("/login?page=error");
                return;
            }

            try {
                if (userDAO.findUserByEmail(email) == null && userDAO.findUserByLogin(login) == null) {
                    boolean success = userDAO.insertUser(login, email, password, name, surname);
                    if (success) session.setAttribute("registrationStatus", "success");
                    else session.setAttribute("registrationStatus", "failed");
                } else {
                    session.setAttribute("registrationStatus", "uniqueError");
                }
            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                response.sendRedirect("/login?page=error");
                return;
            }
        } else {
            session.setAttribute("registrationStatus", "failed");
        }

        response.sendRedirect("/");
    }
}