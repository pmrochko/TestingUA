package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.impl.AnswerDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.QuestionDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.TestDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.enums.AnswerStatus;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Time;

@WebServlet(name = "EditTestServlet", value = "/admin/tests/edit")
public class EditTestServlet extends HttpServlet {

    private static final long serialVersionUID = -3638584086711159799L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String testID = request.getParameter("id");
        HttpSession session = request.getSession();

        if (testID != null && !testID.isBlank()) {

            try {
                TestDAOImpl testDAOImpl = new TestDAOImpl();
                Test test = testDAOImpl.findTestByID(Integer.parseInt(testID));
                if (test != null) {
                    request.setAttribute("editingTest", test);
                    request.getRequestDispatcher(Path.ADMIN_EDIT_TEST_PAGE).forward(request, response);
                } else {
                    session.setAttribute("errorMessage", "test = null");
                    session.setAttribute("prevPage", getServletContext().getContextPath());
                    response.sendRedirect("/error");
                }
            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                session.setAttribute("prevPage", getServletContext().getContextPath());
                response.sendRedirect("/error");
            }

        } else {
            session.setAttribute("errorMessage", "ID of the test = null");
            session.setAttribute("prevPage", getServletContext().getContextPath());
            response.sendRedirect("/error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action != null && !action.isBlank()) {

            String id = request.getParameter("id");

            if (id != null && !id.isBlank()) {

                switch (action) {
                    case "updateTest":
                        String updateSubject = request.getParameter("subjectSelect");
                        String updateTitle = request.getParameter("title");
                        String updateDescription = request.getParameter("description");
                        String updateDifficulty = request.getParameter("difficultySelect");
                        String updateTime = request.getParameter("time");

                        try {
                            TestDAOImpl testDAOImpl = new TestDAOImpl();
                            testDAOImpl.updateTest(
                                    Integer.parseInt(updateSubject),
                                    updateTitle,
                                    updateDescription,
                                    updateDifficulty,
                                    Time.valueOf(updateTime),
                                    Integer.parseInt(id)
                                    );
                        } catch (DBException e) {
                            session.setAttribute("errorMessage", e.getMessage());
                            session.setAttribute("prevPage", getServletContext().getContextPath());
                            response.sendRedirect("/error");
                        }
                        break;

                    case "addQuestion":
                        String question = request.getParameter("question");

                        if (question != null && !question.isBlank()) {

                            try {
                                QuestionDAOImpl questionDAOImpl = new QuestionDAOImpl();
                                boolean check = questionDAOImpl.insertQuestion(question, Integer.parseInt(id));

                                if (check) session.setAttribute("addedQuestion", "success");
                                else session.setAttribute("addedQuestion", "failed");

                            } catch (DBException e) {
                                e.printStackTrace();
                                session.setAttribute("addedQuestion", "failed");
                            }
                        } else {
                            session.setAttribute("addedQuestion", "empty");
                        }
                        break;

                    case "updateQuestion":
                        String newQuestion = request.getParameter("newQuestion");
                        String questionID = request.getParameter("questionID");

                        if (newQuestion != null && !newQuestion.isBlank() &&
                                questionID != null && !questionID.isBlank()) {

                            try {
                                QuestionDAOImpl questionDAOImpl = new QuestionDAOImpl();
                                questionDAOImpl.updateQuestion(newQuestion, Integer.parseInt(questionID));

                            } catch (DBException e) {
                                session.setAttribute("errorMessage", e.getMessage());
                                session.setAttribute("prevPage", getServletContext().getContextPath());
                                response.sendRedirect("/error");
                            }
                        }
                        break;

                    case "addAnswer":
                        String selectedQuestion = request.getParameter("questionID");
                        String answerText = request.getParameter("answerText");
                        String answerStatusSelect = request.getParameter("answerStatusSelect");

                        if (selectedQuestion != null && !selectedQuestion.isBlank() &&
                                answerText != null && !answerText.isBlank() &&
                                answerStatusSelect != null && !answerStatusSelect.isBlank() &&
                                AnswerStatus.isValidEnum(answerStatusSelect)) {

                            try {
                                AnswerDAOImpl answerDAOImpl = new AnswerDAOImpl();
                                boolean check = answerDAOImpl.insertAnswer(Integer.parseInt(selectedQuestion), answerStatusSelect, answerText);

                                if (check) session.setAttribute("addedAnswer", "success");
                                else session.setAttribute("addedAnswer", "failed");

                            } catch (DBException e) {
                                e.printStackTrace();
                                session.setAttribute("addedAnswer", "failed");
                            }
                        } else {
                            session.setAttribute("addedAnswer", "empty");
                        }

                        session.setAttribute("selectedQuestionID", selectedQuestion);
                        break;

                    case "updateAnswer":
                        String answerID = request.getParameter("answerID");
                        String newAnswer = request.getParameter("newAnswer");
                        String newStatus = request.getParameter("newStatus");

                        if (answerID != null && newAnswer != null && newStatus != null &&
                                !answerID.isBlank() && !newAnswer.isBlank() && !newStatus.isBlank()) {

                            try {
                                AnswerDAOImpl answerDAOImpl = new AnswerDAOImpl();
                                answerDAOImpl.updateAnswer(newAnswer, newStatus, Integer.parseInt(answerID));
                            } catch (DBException e) {
                                session.setAttribute("errorMessage", e.getMessage());
                                session.setAttribute("prevPage", getServletContext().getContextPath());
                                response.sendRedirect("/error");
                            }

                        }
                        break;
                }
                response.sendRedirect(Path.ADMIN_TESTS_EDIT_REDIRECT + id);
                return;
            }
        }

        response.sendRedirect(Path.ADMIN_TESTS_REDIRECT);
    }
}