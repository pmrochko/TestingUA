package com.myproject.testingua.controllers.servlets;

import com.myproject.testingua.DataBase.DAO.UserDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {

    private final static String EDIT = "edit";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("WEB-INF/views/userProfile.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action != null && action.equals(EDIT)) {
            HttpSession session = request.getSession();
            User currUser = (User) session.getAttribute("currentUser");
            String choice = request.getParameter("form");
            String value;

            if (currUser != null && choice != null) {
                try {                       // Must be created correct ERROR_PAGE structure !!!
                    switch (choice) {
                        case "surnameForm":
                            value = request.getParameter("surname");
                            if (value != null && !value.isEmpty()) {
                                UserDAO userDAO = new UserDAO();
                                boolean succ = userDAO.updateUserSurname(value, currUser.getId());
                                if (succ) { currUser.setSurname(value); }
                            }
                            break;
                        case "nameForm":
                            value = request.getParameter("name");
                            if (value != null && !value.isEmpty()) {
                                UserDAO userDAO = new UserDAO();
                                boolean succ = userDAO.updateUserName(value, currUser.getId());
                                if (succ) { currUser.setName(value); }
                            }
                            break;
                        case "emailForm":
                            value = request.getParameter("email");
                            if (value != null && !value.isEmpty()) {
                                UserDAO userDAO = new UserDAO();
                                boolean succ = userDAO.updateUserEmail(value, currUser.getId());
                                if (succ) { currUser.setEmail(value); }
                            }
                            break;
                        case "telForm":
                            value = request.getParameter("tel");
                            if (value != null && !value.isEmpty()) {
                                UserDAO userDAO = new UserDAO();
                                boolean succ = userDAO.updateUserTel(value, currUser.getId());
                                if (succ) { currUser.setTel(value); }
                            }
                            break;
                        case "loginForm":
                            value = request.getParameter("login");
                            if (value != null && !value.isEmpty()) {
                                UserDAO userDAO = new UserDAO();
                                boolean succ = userDAO.updateUserLogin(value, currUser.getId());
                                if (succ) { currUser.setLogin(value); }
                            }
                            break;
                        case "passwordForm":
                            String oldPass = request.getParameter("curr-pass");
                            String newPass = request.getParameter("new-pass");
                            String repeatNewPass = request.getParameter("repeat-new-pass");

                            if ((oldPass != null) && (newPass != null) && (repeatNewPass != null) &&
                                    (!oldPass.isEmpty()) && (!newPass.isEmpty()) && (!repeatNewPass.isEmpty())) {

                                UserDAO userDAO = new UserDAO();
                                String checkPass = userDAO.findUserByID(currUser.getId()).getPassword();

                                if (oldPass.equals(checkPass) && newPass.equals(repeatNewPass)) {
                                    boolean succ = userDAO.updateUserPassword(newPass, currUser.getId());
                                    if (succ) {
                                        currUser.setPassword(newPass);
                                        session.setAttribute("changePassword", "success");
                                    } else
                                        session.setAttribute("changePassword", "failed");
                                } else
                                    session.setAttribute("changePassword", "incorrectInput");
                            } else
                                session.setAttribute("changePassword", "emptyInput");
                            break;
                    }
                } catch (DBException e) {
                    e.printStackTrace();
                }                              // Must be created correct ERROR_PAGE structure !!!
            }
        }

        response.sendRedirect("profile");
    }
}