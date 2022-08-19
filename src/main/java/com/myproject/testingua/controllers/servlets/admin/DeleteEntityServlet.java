package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.impl.AnswerDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.QuestionDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.TestDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteEntityServlet", value = "/admin/tests/delete")
public class DeleteEntityServlet extends HttpServlet {

    private static final long serialVersionUID = 6252845387114414926L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.sendError(404);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String entity = request.getParameter("entity");
        String entityID = request.getParameter("entityID");
        String testID = request.getParameter("testID");
        HttpSession session = request.getSession();

        if (entity != null && !entity.isBlank() && testID != null && !testID.isBlank()) {
            try {
                switch (entity) {
                    case "answer":
                        AnswerDAOImpl answerDAOImpl = new AnswerDAOImpl();
                        answerDAOImpl.deleteAnswerByID(Integer.parseInt(entityID));
                        response.sendRedirect(Path.ADMIN_TESTS_EDIT_REDIRECT + testID);
                        return;
                    case "question":
                        QuestionDAOImpl questionDAOImpl = new QuestionDAOImpl();
                        questionDAOImpl.deleteQuestionByID(Integer.parseInt(entityID));
                        response.sendRedirect(Path.ADMIN_TESTS_EDIT_REDIRECT + testID);
                        return;
                    case "test":
                        TestDAOImpl testDAOImpl = new TestDAOImpl();
                        testDAOImpl.deleteTestByID(Integer.parseInt(testID));
                        break;
                }
            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                session.setAttribute("prevPage", getServletContext().getContextPath());
                response.sendRedirect("/error");
            }
        }

        response.sendRedirect(Path.ADMIN_TESTS_REDIRECT);
    }
}
