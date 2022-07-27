package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.AnswerDAO;
import com.myproject.testingua.DataBase.DAO.QuestionDAO;
import com.myproject.testingua.DataBase.DAO.TestDAO;
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

        if (testID != null && !testID.isBlank()) {

            try {
                TestDAO testDAO = new TestDAO();
                Test test = testDAO.findTestByID(Integer.parseInt(testID));
                if (test != null) {
                    request.setAttribute("editingTest", test);
                    request.getRequestDispatcher(Path.ADMIN_EDIT_TEST_PAGE).forward(request, response);
                } else {
                    // error-page
                    request.getRequestDispatcher(Path.ADMIN_TESTS_PAGE).forward(request, response);
                }
            } catch (DBException e) {
                e.printStackTrace();
                //error-page
            }

        } else {
            //error-page
            request.getRequestDispatcher(Path.ADMIN_TESTS_PAGE).forward(request, response);
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
                            TestDAO testDAO = new TestDAO();
                            testDAO.updateTest(
                                    Integer.parseInt(updateSubject),
                                    updateTitle,
                                    updateDescription,
                                    updateDifficulty,
                                    Time.valueOf(updateTime),
                                    Integer.parseInt(id)
                                    );
                        } catch (DBException e) {
                            e.printStackTrace();
                        }
                        break;

                    case "addQuestion":
                        String question = request.getParameter("question");

                        if (question != null && !question.isBlank()) {

                            try {
                                QuestionDAO questionDAO = new QuestionDAO();
                                boolean check = questionDAO.insertQuestion(question, Integer.parseInt(id));

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
                                QuestionDAO questionDAO = new QuestionDAO();
                                questionDAO.updateQuestion(newQuestion, Integer.parseInt(questionID));

                            } catch (DBException e) {
                                e.printStackTrace();
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
                                AnswerDAO answerDAO = new AnswerDAO();
                                boolean check = answerDAO.insertAnswer(Integer.parseInt(selectedQuestion), answerStatusSelect, answerText);

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
                        //if (selectedQuestion != null) session.removeAttribute("selectedQuestion");
                        break;

                    case "updateAnswer":
                        String answerID = request.getParameter("answerID");
                        String newAnswer = request.getParameter("newAnswer");
                        String newStatus = request.getParameter("newStatus");

                        if (answerID != null && newAnswer != null && newStatus != null &&
                                !answerID.isBlank() && !newAnswer.isBlank() && !newStatus.isBlank()) {

                            try {
                                AnswerDAO answerDAO = new AnswerDAO();
                                answerDAO.updateAnswer(newAnswer, newStatus, Integer.parseInt(answerID));
                            } catch (DBException e) {
                                e.printStackTrace();
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