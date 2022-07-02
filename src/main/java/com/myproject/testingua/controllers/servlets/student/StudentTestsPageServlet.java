package com.myproject.testingua.controllers.servlets.student;

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

@WebServlet(name = "StudentTestsPageServlet", value = "/student/tests")
public class StudentTestsPageServlet extends HttpServlet {

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
        request.getRequestDispatcher(Path.STUDENT_TESTS_PAGE).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}