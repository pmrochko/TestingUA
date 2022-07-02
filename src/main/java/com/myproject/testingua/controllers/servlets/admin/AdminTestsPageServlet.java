package com.myproject.testingua.controllers.servlets.admin;

import com.myproject.testingua.DataBase.DAO.SubjectDAO;
import com.myproject.testingua.DataBase.DAO.TestDAO;
import com.myproject.testingua.DataBase.DBException;
import com.myproject.testingua.controllers.Path;
import com.myproject.testingua.models.entity.Subject;
import com.myproject.testingua.models.entity.Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminTestsPageServlet", value = "/admin/tests")
public class AdminTestsPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Subject> subjects = null;
        List<Test> tests = null;
        try {
            SubjectDAO subjectDAO = new SubjectDAO();
            subjects = subjectDAO.findAllSubjects();
            TestDAO testDAO = new TestDAO();
            tests = testDAO.findAllTests();
        } catch (DBException e) {
            e.printStackTrace();
        }

        if (subjects != null && tests != null) {
            session.setAttribute("subjectsList", subjects);
            request.setAttribute("testsList", tests);
        }
        request.getRequestDispatcher(Path.ADMIN_TESTS_PAGE).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action != null && !action.isBlank()) {

            String subjectID = request.getParameter("subjectSelect");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String difficulty = request.getParameter("difficultySelect");
            String time = request.getParameter("time");

            if (subjectID != null && title != null && difficulty != null &&
                    !subjectID.isBlank() && !title.isBlank() && !difficulty.isBlank()) {

                try {
                    TestDAO testDAO = new TestDAO();
                    double testTime = 0;
                    if (time != null && !time.isBlank()) {
                        testTime = Double.parseDouble(time);
                    }
                    boolean check = testDAO.insertTest(
                            Integer.parseInt(subjectID),
                            title,
                            description,
                            difficulty,
                            testTime
                    );

                    if (check) session.setAttribute("addedTest", "success");
                    else session.setAttribute("addedTest", "failed");

                } catch (DBException e) {
                    e.printStackTrace();
                    session.setAttribute("addedTest", "failed");
                }
            } else {
                session.setAttribute("addedTest", "empty");
            }
        }

        response.sendRedirect("/admin/tests");
    }
}