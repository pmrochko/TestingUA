package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.UserDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentsPageServlet", value = "/admin/students")
public class StudentsPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Initialize the list of students
        try {
            UserDAO userDAO = new UserDAO();
            List<User> usersList = userDAO.findAllUsers();
            if (usersList != null) {
                request.setAttribute("usersList", usersList);
            }
        } catch (DBException e) {
            e.printStackTrace();
        }

        String editingUserID = request.getParameter("editingUserID");
        if (editingUserID != null && !editingUserID.isEmpty()) {
            // Get a modal form to edit user data
            try {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.findUserByID(Integer.parseInt(editingUserID));
                if (user != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("editingUser", user);
                    request.setAttribute("openModalEdit", true);
                }
            } catch (DBException e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher(Path.ADMIN_STUDENTS_PAGE).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String userID = request.getParameter("userID");

        if (action != null && !action.isEmpty()) {

            if (action.equals("edit")) {

                String name = request.getParameter("name");
                String surname = request.getParameter("surname");
                String email = request.getParameter("email");
                String login = request.getParameter("login");
                String tel = request.getParameter("tel");

                User editingUser = (User) request.getSession().getAttribute("editingUser");

                try {
                    UserDAO userDAO = new UserDAO();
                    if (name != null && !name.isBlank() && !editingUser.getName().equals(name)) {
                        userDAO.updateUserName(name, editingUser.getId());
                    }
                    if (surname != null && !surname.isBlank() && !editingUser.getSurname().equals(surname)) {
                        userDAO.updateUserSurname(surname, editingUser.getId());
                    }
                    if (email != null && !email.isBlank() && !editingUser.getEmail().equals(email)) {
                        userDAO.updateUserEmail(email, editingUser.getId());
                    }
                    if (login != null && !login.isBlank() && !editingUser.getLogin().equals(login)) {
                        userDAO.updateUserLogin(login, editingUser.getId());
                    }
                    if (tel != null && !tel.isBlank() && !editingUser.getTel().equals(tel)) {
                        userDAO.updateUserTel(tel, editingUser.getId());
                    }
                } catch (DBException e) {
                    e.printStackTrace();
                }

                request.getSession().removeAttribute("editingUser");

            } else {
                if (userID != null && !userID.isEmpty()) {
                    boolean newBlockedStatus = action.equals("block");

                    try {
                        UserDAO userDAO = new UserDAO();
                        userDAO.updateUserBanStatus(newBlockedStatus, Integer.parseInt(userID));
                    } catch (DBException e) {
                        e.printStackTrace();        // Must be correct ERROR-PAGE realization
                    }
                }
            }
        }

        response.sendRedirect("/admin/students");
    }
}
