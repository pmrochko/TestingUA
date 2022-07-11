package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.AnswerDAO;
import com.myproject.testingua.DataBase.DAO.QuestionDAO;
import com.myproject.testingua.DataBase.DAO.TestDAO;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String entity = request.getParameter("entity");
        String entityID = request.getParameter("entityID");
        String testID = request.getParameter("testID");

        if (entity != null && !entity.isBlank() && testID != null && !testID.isBlank()) {
            try {
                switch (entity) {
                    case "answer":
                        AnswerDAO answerDAO = new AnswerDAO();
                        answerDAO.deleteAnswerByID(Integer.parseInt(entityID));
                        response.sendRedirect(Path.ADMIN_TESTS_EDIT_REDIRECT + testID);
                        return;
                    case "question":
                        QuestionDAO questionDAO = new QuestionDAO();
                        questionDAO.deleteQuestionByID(Integer.parseInt(entityID));
                        response.sendRedirect(Path.ADMIN_TESTS_EDIT_REDIRECT + testID);
                        return;
                    case "test":
                        TestDAO testDAO = new TestDAO();
                        testDAO.deleteTestByID(Integer.parseInt(testID));
                        break;
                }
            } catch (DBException ex) {
                // error-page
                ex.printStackTrace();
            }
        }

        response.sendRedirect(Path.ADMIN_TESTS_REDIRECT);
    }
}
