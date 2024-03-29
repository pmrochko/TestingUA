package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DAO.impl.HistoryTestsDAOImpl;
import com.myproject.testingua.DataBase.DAO.impl.TestDAOImpl;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.HistoryOfTest;
import com.myproject.testingua.models.entity.Test;
import com.myproject.testingua.models.entity.User;
import com.myproject.testingua.models.enums.TestProgressStatus;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ProcessPassingTestServlet", value = "/students/tests/start")
public class ProcessPassingTestServlet extends HttpServlet {

    private static final long serialVersionUID = -5003568377491971434L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id != null && !id.isBlank()) {

            try {
                Test test = new TestDAOImpl().findTestByID(Integer.parseInt(id));
                User student = (User) session.getAttribute("currentUser");

                if (test != null && student != null) {
                    session.setAttribute("startedTest", test);

                    if (!HistoryOfTest.historyContainRecordedTest(test, student.getId())) {
                        HistoryTestsDAOImpl historyTestsDAOImpl = new HistoryTestsDAOImpl();
                        historyTestsDAOImpl.insertRecordOfHistory(
                                student.getId(),
                                test.getId(),
                                0,
                                TestProgressStatus.STARTED.name()
                        );
                    }

                    request.getRequestDispatcher(Path.STUDENT_PROCESS_PASSING_TEST_PAGE).forward(request, response);
                    return;
                }

            } catch (DBException e) {
                session.setAttribute("errorMessage", e.getMessage());
                session.setAttribute("prevPage", getServletContext().getContextPath());
                response.sendRedirect("/error");
            }
        }
        response.sendRedirect(Path.STUDENT_TESTS_PAGE);

    }
}
