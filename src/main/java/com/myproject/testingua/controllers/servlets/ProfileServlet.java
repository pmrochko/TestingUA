package com.myproject.testingua.controllers.servlets;

import com.myproject.testingua.DataBase.DAO.impl.UserDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.models.entity.User;
import com.myproject.testingua.validation.DataValidator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = -7052381877104669441L;
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
                            if (value != null && !value.isEmpty() && DataValidator.isValidSurname(value)) {
                                UserDAOImpl userDAOImpl = new UserDAOImpl();
                                boolean succ = userDAOImpl.updateUserSurname(value, currUser.getId());
                                if (succ) { currUser.setSurname(value); }
                            }
                            break;
                        case "nameForm":
                            value = request.getParameter("name");
                            if (value != null && !value.isEmpty() && DataValidator.isValidName(value)) {
                                UserDAOImpl userDAOImpl = new UserDAOImpl();
                                boolean succ = userDAOImpl.updateUserName(value, currUser.getId());
                                if (succ) { currUser.setName(value); }
                            }
                            break;
                        case "emailForm":
                            value = request.getParameter("email");
                            if (value != null && !value.isEmpty() && DataValidator.isValidEmail(value)) {
                                UserDAOImpl userDAOImpl = new UserDAOImpl();
                                boolean succ = userDAOImpl.updateUserEmail(value, currUser.getId());
                                if (succ) { currUser.setEmail(value); }
                            }
                            break;
                        case "telForm":
                            value = request.getParameter("tel");
                            if (value != null && !value.isEmpty() && DataValidator.isValidTel(value)) {
                                UserDAOImpl userDAOImpl = new UserDAOImpl();
                                boolean succ = userDAOImpl.updateUserTel(value, currUser.getId());
                                if (succ) { currUser.setTel(value); }
                            }
                            break;
                        case "loginForm":
                            value = request.getParameter("login");
                            if (value != null && !value.isEmpty() && DataValidator.isValidLogin(value)) {
                                UserDAOImpl userDAOImpl = new UserDAOImpl();
                                boolean succ = userDAOImpl.updateUserLogin(value, currUser.getId());
                                if (succ) { currUser.setLogin(value); }
                            }
                            break;
                        case "passwordForm":
                            String oldPass = request.getParameter("curr-pass");
                            String newPass = request.getParameter("new-pass");
                            String repeatNewPass = request.getParameter("repeat-new-pass");

                            if ((oldPass != null) && (newPass != null) && (repeatNewPass != null) &&
                                    (!oldPass.isEmpty()) && (!newPass.isEmpty()) && (!repeatNewPass.isEmpty()) &&
                                    (DataValidator.isValidPassword(newPass))) {

                                UserDAOImpl userDAOImpl = new UserDAOImpl();
                                String checkPass = userDAOImpl.findUserByID(currUser.getId()).getPassword();

                                if (oldPass.equals(checkPass) && newPass.equals(repeatNewPass)) {
                                    boolean succ = userDAOImpl.updateUserPassword(newPass, currUser.getId());
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