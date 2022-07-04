package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.Answer;
import com.myproject.testingua.models.entity.Question;
import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.enums.QuestionStatus;
import com.myproject.testingua.models.enums.TestProgressStatus;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "TestResultsServlet", value = "/student/tests/result")
public class TestResultsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Test test = (Test) session.getAttribute("startedTest");
        String result = (String) session.getAttribute("testResult");

        if (test != null && result != null) {

            request.getRequestDispatcher(Path.STUDENT_RESULT_TEST_PAGE).forward(request, response);

        } else {

            request.getRequestDispatcher(Path.ERROR_PAGE).forward(request, response);

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Test test = (Test) session.getAttribute("startedTest");
        Map<Question, List<Integer>> resultMap = new HashMap<>();

        for (Question question : test.getQuestionsList()) {

            List<Integer> answersID = new ArrayList<>();

            if (question.getQuestionStatus() == QuestionStatus.SIMPLE) {

                String valueName = "answ" + question.getId();
                String result = request.getParameter(valueName);
                if (result != null && !result.isBlank()) {
                    answersID.add(Integer.valueOf(result));
                }

            } else if (question.getQuestionStatus() == QuestionStatus.COMPLEX) {

                for (Answer answer : question.getAnswersList()) {

                    String valueName = "answ" + question.getId() + '_' + answer.getId();
                    String result = request.getParameter(valueName);

                    if (result != null && !result.isBlank()) {
                        answersID.add(Integer.valueOf(result));
                    }
                }
            }

            resultMap.put(question, answersID);
        }

        System.out.println(resultMap);
        long resultScore = 0;
        try {
            resultScore = Test.calculationResult(resultMap);
        } catch (DBException e) {
            e.printStackTrace();
            // error-page
        }
        System.out.println(resultScore);

        session.setAttribute("testResult", resultScore);

        String time = request.getParameter("time");
        if (time != null && !time.isBlank() && time.equals("EXPIRED")) {
            session.setAttribute("testStatus", TestProgressStatus.TIMEOUT);
        } else {
            session.setAttribute("testStatus", TestProgressStatus.FINISHED);
        }


        response.sendRedirect("/student/tests/result");
    }
}
