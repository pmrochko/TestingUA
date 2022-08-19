package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.impl.UserDAOImpl;
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

    private static final long serialVersionUID = 8249045890195241906L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Initialize the list of students
        try {
            UserDAOImpl userDAOImpl = new UserDAOImpl();
            List<User> usersList = userDAOImpl.findAllUsers();
            if (usersList != null) {
                request.setAttribute("usersList", usersList);
            }
        } catch (DBException e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        String editingUserID = request.getParameter("editingUserID");
        if (editingUserID != null && !editingUserID.isEmpty()) {
            // Get a modal form to edit user data
            try {
                UserDAOImpl userDAOImpl = new UserDAOImpl();
                User user = userDAOImpl.findUserByID(Integer.parseInt(editingUserID));
                if (user != null) {
                    session.setAttribute("editingUser", user);
                    request.setAttribute("openModalEdit", true);
                }
            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                session.setAttribute("prevPage", getServletContext().getContextPath());
                response.sendRedirect("/error");
            }
        }

        request.getRequestDispatcher(Path.ADMIN_STUDENTS_PAGE).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String userID = request.getParameter("userID");
        HttpSession session = request.getSession();

        if (action != null && !action.isEmpty()) {
            if (action.equals("edit")) {

                String name = request.getParameter("name");
                String surname = request.getParameter("surname");
                String email = request.getParameter("email");
                String login = request.getParameter("login");
                String tel = request.getParameter("tel");

                User editingUser = (User) request.getSession().getAttribute("editingUser");

                try {
                    UserDAOImpl userDAOImpl = new UserDAOImpl();
                    if (name != null && !name.isBlank() && !editingUser.getName().equals(name)) {
                        userDAOImpl.updateUserName(name, editingUser.getId());
                    }
                    if (surname != null && !surname.isBlank() && !editingUser.getSurname().equals(surname)) {
                        userDAOImpl.updateUserSurname(surname, editingUser.getId());
                    }
                    if (email != null && !email.isBlank() && !editingUser.getEmail().equals(email)) {
                        userDAOImpl.updateUserEmail(email, editingUser.getId());
                    }
                    if (login != null && !login.isBlank() && !editingUser.getLogin().equals(login)) {
                        userDAOImpl.updateUserLogin(login, editingUser.getId());
                    }
                    if (tel != null && !tel.isBlank() && !editingUser.getTel().equals(tel)) {
                        userDAOImpl.updateUserTel(tel, editingUser.getId());
                    }
                } catch (DBException e) {
                    session.setAttribute("errorMessage", e.getMessage());
                    session.setAttribute("prevPage", getServletContext().getContextPath());
                    response.sendRedirect("/error");
                }

                request.getSession().removeAttribute("editingUser");

            } else if (userID != null && !userID.isEmpty()) {
                boolean newBlockedStatus = action.equals("block");

                try {
                    UserDAOImpl userDAOImpl = new UserDAOImpl();
                    userDAOImpl.updateUserBanStatus(newBlockedStatus, Integer.parseInt(userID));
                } catch (DBException e) {
                    session.setAttribute("errorMessage", e.getMessage());
                    session.setAttribute("prevPage", getServletContext().getContextPath());
                    response.sendRedirect("/error");
                }
            }
        }

        response.sendRedirect("/admin/students");
    }
}
