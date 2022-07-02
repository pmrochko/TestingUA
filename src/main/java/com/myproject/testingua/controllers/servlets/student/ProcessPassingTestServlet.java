package com.myproject.testingua.controllers.servlets.student;

import com.myproject.testingua.DataBase.DAO.TestDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.Test;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ProcessPassingTestServlet", value = "/students/tests/start")
public class ProcessPassingTestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        if (id != null && !id.isBlank()) {

            try {
                Test test = new TestDAO().findTestByID(Integer.parseInt(id));

                if (test != null) {
                    session.setAttribute("startedTest", test);
                    request.getRequestDispatcher(Path.STUDENT_PROCESS_PASSING_TEST_PAGE).forward(request, response);
                    return;
                }

            } catch (DBException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(Path.STUDENT_TESTS_PAGE);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
